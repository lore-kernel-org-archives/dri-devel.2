Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54282C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C1110E95C;
	Tue, 25 Aug 2026 08:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n/pf9BYC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5A610E958
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2825D404E6
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D91F000E9;
 Tue, 25 Aug 2026 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645438;
 bh=/C0QcZwtD7XRCRXsbSfBbgOcvnDEOBVki2255VoDXpQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n/pf9BYC4D5scO975AyNHqPpIBnNSjnAqxpqmBFDZyxSLSEnoR/isMtozr6+oD3KP
 wj8bpZK5UaGnDhJoZJZ77LF9CsaZ9zWClVzNrEjmgEHhfBDwMLU2Ql+yGOzcNXnqlo
 99igZSy54AtNpXnnMI7mhD8xFyqRyyct4f3PCZ4WkShn+geEgg/Ge/Xs6W1TSE3Jn/
 fSHjmQrwmtrmzBaNy9OBzsjB8CJucI6PmTtWAFLRYNl5VwE6CV96Yez036ZLqQLkpp
 PMsKa/s4LCb+rHh6C2sAk6ov7SuW0rlEgfNMu6cnB4sDC2Ay/lZ8mG2zCIvXitFYv+
 6l7CXrjde1ECg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/12] drm/fabric: implement mutation netlink
 operations
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <5b008798364477a2740ebb18544bddfa16f7d512.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <5b008798364477a2740ebb18544bddfa16f7d512.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:37 +0000
Message-Id: <20260825081037.D57D91F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Mutation operations (NEW/ADD/SET) only return an ACK instead of =
replying with a full message.
- [Medium] Notifications emitted in response to mutation requests do not ho=
nor the NLM_F_ECHO flag.
- [Medium] Extraneous wrapping nest used for FABRIC_NEW parameters.
- [Low] Missing extended ACK coverage when required nested attributes in pe=
er descriptors are absent.
--

--- Patch [9]: [RFC PATCH 09/12] drm/fabric: implement mutation netlink ope=
rations ---
commit 7000874bd5559d10291fdcd411ac9f167a4334c9
Author: Konstantin Sinyuk <ksinyuk@kernel.org>

    drm/fabric: implement mutation netlink operations
   =20
    Connect the six provisioning operations to the core mutation helpers and
    add the generated operation and policy source that dispatches to them.
   =20
    Resolve and pin mutation targets in pre_doit, run each transaction under
    drm_fabric_mutation_lock, call the provider without drm_fabric_lock hel=
d,
    and release references in post_doit. All six require GENL_ADMIN_PERM and
    are confined to init_net.
   =20
    A failed provider callback returns its error with core state unchanged.
    Successful mutations emit notifications after commit, carrying the
    resulting topology generation.

> diff --git a/drivers/gpu/drm/fabric/drm_fabric_netlink.c b/drivers/gpu/dr=
m/fabric/drm_fabric_netlink.c
> index fef2d4c8f5bb9..1a0f293723e95 100644
> --- a/drivers/gpu/drm/fabric/drm_fabric_netlink.c
> +++ b/drivers/gpu/drm/fabric/drm_fabric_netlink.c
[ ... ]
> +/* A nested policy cannot mark members required; check type and instance=
-id here. */
> +static int drm_fabric_parse_new_params(struct genl_info *info,
> +					enum drm_fabric_type *type,
> +					const char **name, u64 *instance_id)
> +{
> +	struct nlattr *pa[DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX + 1];
> +	struct nlattr *nest;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_FABRIC_NEW_PARAMS))
> +		return -EINVAL;
> +
> +	nest =3D info->attrs[DRM_FABRIC_A_FABRIC_NEW_PARAMS];
> +	ret =3D nla_parse_nested(pa, DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX, nest,
> +			       drm_fabric_fabric_new_params_nl_policy,
> +			       info->extack);

[Severity: Medium]
Does this create an extra wrapping nest for the new parameters?

Netlink uAPI guidelines for new families prefer flat attributes over wrappi=
ng
nests. Is it possible to avoid using DRM_FABRIC_A_FABRIC_NEW_PARAMS and ins=
tead
place these parameters directly in the main attribute set?

[ ... ]
> +int drm_fabric_nl_endpoint_set_doit(struct sk_buff *skb,
> +				    struct genl_info *info)
> +{
[ ... ]
> +	if (!change.valid)
> +		return -EINVAL;
> +
> +	return drm_fabric_endpoint_set(ep, &change);
> +}

[Severity: Medium]
Should this function reply with a full message rather than just an ACK?

New netlink families should reply to mutation operations (like SET and NEW)
with a full message carrying the object state, rather than just relying on
a generic ACK. This applies here as well as to drm_fabric_nl_port_set_doit()
and drm_fabric_nl_port_peer_new_doit().

[ ... ]
> +int drm_fabric_nl_port_peer_new_doit(struct sk_buff *skb,
> +				     struct genl_info *info)
> +{
> +	struct drm_fabric_port *port =3D info->user_ptr[0];
> +	struct nlattr *pa[DRM_FABRIC_A_PEER_ATTRS_MAX + 1];
> +	struct drm_fabric_peer peer =3D {};
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_PEER))
> +		return -EINVAL;
> +
> +	ret =3D nla_parse_nested(pa, DRM_FABRIC_A_PEER_ATTRS_MAX,
> +			       info->attrs[DRM_FABRIC_A_PEER],
> +			       drm_fabric_peer_nl_policy, info->extack);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * A nested policy cannot require members; require the complete peer
> +	 * descriptor here.
> +	 */
> +	if (!pa[DRM_FABRIC_A_PEER_ATTRS_PEER_ID] ||
> +	    !pa[DRM_FABRIC_A_PEER_ATTRS_TYPE] ||
> +	    !pa[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX])
> +		return -EINVAL;

[Severity: Low]
Could this manual check use NL_REQ_ATTR_CHECK() to provide extended ACK
information?

Currently, this returns a bare -EINVAL without populating the extack to inf=
orm
userspace which specific nested attribute was missing from the peer descrip=
tor.

> +
> +	peer.peer_id =3D nla_get_u64(pa[DRM_FABRIC_A_PEER_ATTRS_PEER_ID]);
> +	peer.peer_type =3D nla_get_u32(pa[DRM_FABRIC_A_PEER_ATTRS_TYPE]);
> +	peer.port_index =3D nla_get_u32(pa[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX]);
> +
> +	return drm_fabric_port_peer_new(port, &peer);
> +}
[ ... ]
> +void drm_fabric_emit_endpoint_change(struct drm_fabric_endpoint *ep, u32=
 generation)
> +{
> +	drm_fabric_endpoint_event_send(DRM_FABRIC_CMD_ENDPOINT_CHANGE_NTF, ep,
> +				       generation);
> +}

[Severity: Medium]
Will these notifications honor the NLM_F_ECHO flag?

The event send functions (such as drm_fabric_endpoint_event_send() called h=
ere,
and drm_fabric_emit_port_change()) use genlmsg_multicast() directly without
the originating request context.

When emitting a notification in response to a request, passing the request =
info
to genl_notify() ensures that userspace applications setting NLM_F_ECHO will
correctly receive their own mutations back.

> diff --git a/drivers/gpu/drm/fabric/drm_fabric_nl.c b/drivers/gpu/drm/fab=
ric/drm_fabric_nl.c
> index 0325484051466..20b277f27ae9b 100644
> --- a/drivers/gpu/drm/fabric/drm_fabric_nl.c
> +++ b/drivers/gpu/drm/fabric/drm_fabric_nl.c
[ ... ]
> +/* DRM_FABRIC_CMD_FABRIC_NEW - do */
> +static const struct nla_policy drm_fabric_fabric_new_nl_policy[DRM_FABRI=
C_A_FABRIC_NEW_PARAMS + 1] =3D {
> +	[DRM_FABRIC_A_FABRIC_NEW_PARAMS] =3D NLA_POLICY_NESTED(drm_fabric_fabri=
c_new_params_nl_policy),
> +};

[Severity: Medium]
Does this policy enforce an extraneous wrapping nest?

As mentioned earlier, Netlink uAPI guidelines discourage wrapping nests for
new families. Can these parameters be flattened into the main attribute set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D9
