Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E82DC5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 10:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D8C10E002;
	Sun, 23 Aug 2026 10:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="e7n9VUiN";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="AZ7okH+L";
	dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC54C10E002
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 10:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787481868; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=ql/R557KTC8Qzd5rdtBpOA+AsSjI6ABoZkDpQk9wc8LfQ9k66aoixPufIrAy1d+sH1
 O/YPDHspO9PFXR1IsONyYka25L4GpLxBSriQFXUomYyXuvu56DoGLpDvHcEvGSRSLCig
 T5okY0bjMhAbEezfEVGXrmB60UbL2k7h2SWcY+16WezOu5nAw7B3kOf+JxySxWHUeFOD
 irWz3vHf22LQ7Zq/xXdGjH9iOzb2LdrLC4I3Xw6ltpDAyUhPb6hkNJ/APbh/s/HTQh9q
 LRMnHN34YLkkwRxlYbo3ppHdmEvvkFNbpfPFBzpc3fRPAs+r2qM4Qn8XZ8I1F7wG2/do
 JWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787481868;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=rMPaLIi+e8I9vdpbb+h8fITM3Z1acOB7L8F8JGiRZe0=;
 b=YjH8QBQ6pDL4+7WiH6A+lpaUM090F5H9gBuhf5E3BFtLBh9h2yKPA3s26ZmmxEg3ec
 12d9zT4QYz9vYgMhoTbrHwo1zV46L40xuX0i+WJ701KwFSKn9cA1RCrKr2u5MSDHXPwX
 R8/SVrWglfvC8btCyGEdpBvJXDk0n0J1lifZyuJqdGAtptiXuBDp6zbEYXy643DYALCV
 G+kXt4Vz3MeX4SVYgmJ/OM3fZNq6kZKRypEGkb5lOOb87BnCHyEpuxIFG9Gvkt61rvPV
 IlxiC6RG7Wk1IiA3TVBkCf9KIRPyH0vVsZzNl5xT3rNY1pIvCjt9ceaGOtBtXWwvnQ/L
 sXWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787481868;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=rMPaLIi+e8I9vdpbb+h8fITM3Z1acOB7L8F8JGiRZe0=;
 b=e7n9VUiNHjSn7VfeS0vmKNfhUFHCUJHeMXvYuFNEqbyffFsF7ey+h0HNBgeTwirBzl
 6aalSfIAg5kFzvufKWiMeYV87uCTxsnfMOOv1mLVDzWd2WpL47/F2q3EOW79wLKWXHlF
 g1UfP3l5WzUoKnyyTq3NI+k7z7DiKo75ZTnI3G2I1TUteBBAENdg7AZadq5+NJU+5fNK
 6OmacbGu7N7ofNMowkxyGmBj3NwO9J8feOSoc7dPFZxZZf7zmkPN2yM2GqGsGo4lwQFH
 pxAhYA/ljZ78jwiTjkMUB7SYsbyG5mybE4Khf5UnPg3zy9IVQOPGRzhrvm3g2/YGowjh
 0yAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787481868;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=rMPaLIi+e8I9vdpbb+h8fITM3Z1acOB7L8F8JGiRZe0=;
 b=AZ7okH+L3QEF/7vGjXDAkk151SWtBze+mpj7KM1CWUKI8AWaBEeUZzFl5aKpomCm2g
 QC3SPo6nWg/nBce1FgBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oKnciHHK5OAyYE8yLD5e6WBWpu+g6xSmk="
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.2 AUTH)
 with ESMTPSA id Qfefb327NAiRWqV
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Sun, 23 Aug 2026 12:44:27 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] drm/ingenic: fix bridge allocation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260823094523.8E96C1F000E9@smtp.kernel.org>
Date: Sun, 23 Aug 2026 12:44:17 +0200
Cc: dri-devel@lists.freedesktop.org,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B29351A-5DEE-436C-8D1B-6558F28DAEFF@goldelico.com>
References: <400ba2fe0d4f76484e929d2efaa32f67a940163a.1787477392.git.hns@goldelico.com>
 <20260823094523.8E96C1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3826.700.81.1.8)
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

(Response created with ChatGPT analyzing patch, drm subsystem, memory =
management and Sahsiko comments)


> Am 23.08.2026 um 11:45 schrieb sashiko-bot@kernel.org:
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential =
issue(s) to consider:
>=20
> New issues:
> - [High] The patch introduces a lifecycle mismatch and memory leak by =
using `devm_` allocations for a DRM bridge inside a component bind =
function, while attaching it to a `drmm_`-managed encoder.
> - [High] Falsely claiming DRM_BRIDGE_OP_EDID and DRM_BRIDGE_OP_DETECT =
capabilities on a bridge that lacks the corresponding callback =
implementations causes a NULL pointer dereference.
>=20
> Pre-existing issues:
> - [High] Unhandled error pointer from =
devm_drm_panel_bridge_add_typed() leads to invalid memory dereference.
> - [High] atomic_check phase corrupts global driver state by directly =
modifying ib->bus_cfg.
> --
>=20
> --- Patch [1]: [PATCH] drm/ingenic: fix bridge allocation ---
> commit caf3be8c5a53047a7d5ddaf2c5ee3db764a2f7fb
> Author: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> drm/ingenic: fix bridge allocation
>=20
> Bridge allocation API has changed and ingenic/drm was broken leading =
to
> a warning. This patch replaces the embedded drm_bridge structure with =
a
> pointer and uses devm_drm_bridge_alloc() to resolve the issue.

Thanks for the review.

- The devm_drm_bridge_alloc() lifecycle concern appears not to apply =
here. The DRM bridge is refcounted, and drm_bridge_attach() takes a =
reference, so the bridge is not simply freed when the device-managed =
reference is released. The existing Ingenic component unbind path also =
unregisters and shuts down the DRM device, allowing the bridge/encoder =
chain to be cleaned up in the normal DRM lifecycle.
- I agree with the DRM_BRIDGE_OP_EDID / DRM_BRIDGE_OP_DETECT finding; =
these flags are not backed by callbacks in ingenic_drm_bridge_funcs and =
will be removed in v2.
- The devm_drm_panel_bridge_add_typed() error handling and the =
ib->bus_cfg modification in atomic_check() are pre-existing issues and =
are unrelated to this patch.

BR,
Nikolaus
>=20
>=20
>=20
>> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c =
b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> index 738a80b2550ff..91fe0ee7ae9ad 100644
>> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> @@ -802,7 +802,7 @@ static int ingenic_drm_bridge_attach(struct =
drm_bridge *bridge,
>> struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(encoder);
>>=20
>> return drm_bridge_attach(encoder, ib->next_bridge,
>> - &ib->bridge, flags);
>> + bridge, flags);
>> }
>>=20
>> static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
>>   struct drm_bridge_state *bridge_state,
>>   struct drm_crtc_state *crtc_state,
>>   struct drm_connector_state *conn_state)
>> {
>> struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
>> struct ingenic_drm_bridge *ib =3D =
to_ingenic_drm_bridge(bridge->encoder);
>>=20
>> ib->bus_cfg =3D bridge_state->output_bus_cfg;
>=20
> [Severity: High]
> This is a pre-existing issue, but does modifying ib->bus_cfg here =
break
> the atomic contract?
>=20
> Since DRM atomic_check can be called for TEST_ONLY commits that are =
meant
> to be discarded, directly overwriting the global driver state here =
corrupts
> the display configuration if a real commit later relies on this =
modified
> state.
>=20
> [ ... ]
>=20
>> @@ -1316,10 +1316,26 @@ static int ingenic_drm_bind(struct device =
*dev, bool has_components)
>>=20
>> drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
>>=20
>=20
> [Severity: High]
> This is a pre-existing issue, but earlier in this same =
ingenic_drm_bind()
> function, what happens if the panel bridge allocation fails?
>=20
> if (panel) {
> bridge =3D devm_drm_panel_bridge_add_typed(dev, panel,
> DRM_MODE_CONNECTOR_DPI);
> drm_panel_put(panel);
> }
>=20
> If devm_drm_panel_bridge_add_typed() fails, it returns an ERR_PTR(). =
This
> unvalidated error pointer is saved into bridge, and eventually passed =
into
> drm_bridge_attach() as ib->next_bridge, where it will be dereferenced =
and
> panic the kernel. Should we check this with IS_ERR() here?
>=20
>> - ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
>> + ib->bridge =3D devm_drm_bridge_alloc(priv->dev, struct drm_bridge,
>> +   base, &ingenic_drm_bridge_funcs);
>> + if (IS_ERR(ib->bridge)) {
>> + ret =3D PTR_ERR(ib->bridge);
>> + goto err_drvdata;
>> + }
>> +
>> + ib->bridge->of_node =3D priv->dev->of_node;
>> ib->next_bridge =3D bridge;
>>=20
>> - ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
>> + ib->bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
>=20
> [Severity: High]
> Does this bridge actually implement these operations?
>=20
> Setting DRM_BRIDGE_OP_EDID and DRM_BRIDGE_OP_DETECT advertises these
> capabilities to the DRM core. However, the ingenic_drm_bridge_funcs
> structure lacks the corresponding .detect, .edid_read, or .get_edid
> callbacks.
>=20
> When the core initializes the bridge connector and queries its state,
> it will unconditionally call these missing functions, leading to a =
NULL
> pointer dereference.
>=20
>> + ib->bridge->interlace_allowed =3D true;
>> +
>> + ret =3D devm_drm_bridge_add(priv->dev, ib->bridge);
>> + if (ret) {
>> + dev_err(dev, "Failed to register DRM bridge: %d\n", ret);
>> + goto err_drvdata;
>> + }
>> +
>> + ret =3D drm_bridge_attach(encoder, ib->bridge, NULL,
>> DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>=20
> [Severity: High]
> Can these devm_ allocations cause a use-after-free or a memory leak on
> unbind?
>=20
> Using devm_drm_bridge_alloc() and devm_drm_bridge_add() inside a =
component
> bind function ties the bridge's lifecycle to device removal, not =
component
> unbind. This means each bind/unbind cycle leaks memory and leaves =
stale
> bridges in the global DRM list.
>=20
> Additionally, the parent encoder is allocated via =
drmm_encoder_alloc(),
> tying its lifecycle to the DRM device, which can outlive the platform
> device if userspace holds an open file descriptor. When the platform
> device is removed, devres frees the bridge early, creating a UAF =
hazard
> when the DRM device later attempts to clean up its encoder bridge =
chains.
>=20
>> if (ret) {
>> dev_err(dev, "Unable to attach bridge\n");
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.17=
87477392.git.hns@goldelico.com?part=3D1

