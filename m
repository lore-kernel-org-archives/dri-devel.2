Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE5606CF96
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9fBtNAf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935C01128AC;
	Thu,  5 Nov 2026 15:54:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FDC1128B4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 737956020A;
 Thu,  5 Nov 2026 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069C11F000C1;
 Thu,  5 Nov 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793894059;
 bh=MlxJZC+8K08kzR8aRG5RkhP33XTO/CF+oHwMFreiqTg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S9fBtNAfZRoBDnuVQn7kqoWO2Dox2Xj+1Iv4Ch4OGGtKpgQIojt/ZzkqA9hd3aTwL
 QorOleTmmWhVGrQWdoEsgWRF1C6xXbjzcDc+vidYOvYgloFsNtkr78n8i71rhX3MXM
 K+HuqYm0SGLrQVFgBNRRStgPjG+h7Lu6/bM/7/hMyT+FbjlS0q8BmL5zHPepMgLYsu
 o+xkARq98BPL/ePj2IXZjXb5sOyTQeh2crq/MmRgnCztUn2dqEM+kLRUKY/NZLkMYc
 8Nbemo0/4OHwNtSYK554G0RW3tsecSre8IEp05rv7sWKTCwEQLrKxf+RN088wCLI9a
 ILjfCSeSO8U0w==
Message-ID: <sashiko-outbox-199368@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: use the safe iterator when removing
 device links
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104025346.1527550-1-vulab@iscas.ac.cn>
References: <20261104025346.1527550-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:54:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/rockchip: wrong unlocked list in rockchip_drm_match_remove()
--

commit e68a6141bb89fc9c57189db5bdc14a46b7da846f
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/rockchip: use the safe iterator when removing device links

This commit changes rockchip_drm_match_remove() to use
list_for_each_entry_safe() when walking dev->links.consumers and calling
device_link_del().

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_drv.c
> index 3099408e9d050..9edfe4db93934 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -356,9 +356,9 @@ int rockchip_drm_endpoint_is_subdriver(struct device_=
node *ep)
> =20
>  static void rockchip_drm_match_remove(struct device *dev)
>  {
> -	struct device_link *link;
> +	struct device_link *link, *tmp;
> =20
> -	list_for_each_entry(link, &dev->links.consumers, s_node)
> +	list_for_each_entry_safe(link, tmp, &dev->links.consumers, s_node)
>  		device_link_del(link);

[Severity: High]
Does walking dev->links.consumers in rockchip_drm_match_remove() actually
remove the stateless device links created by rockchip_drm_match_add(), or
does it walk the wrong list without holding device_links_lock?

In rockchip_drm_match_add(), the links are created with the master device d=
ev
as the consumer and each sub-driver device d as the supplier:

    device_link_add(dev, d, DL_FLAG_STATELESS);

In drivers/base/core.c:device_link_add(), s_node is added to
supplier->links.consumers (which is d->links.consumers) and c_node is added=
 to
consumer->links.suppliers (which is dev->links.suppliers):

    list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
    list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);

Because dev is the consumer rather than the supplier, none of the links
created by rockchip_drm_match_add() are on dev->links.consumers, so they are
all leaked when rockchip_drm_platform_probe() fails or defers and when
rockchip_drm_platform_remove() runs.

In addition, dev->links.consumers and dev->links.suppliers are internal to =
the
driver core and protected by device_links_write_lock(). Because
device_link_del() only acquires and releases that lock inside each call,
iterating dev->links outside drivers/base/core.c leaves the list traversal =
and
tmp pointer unserialized against concurrent device link changes. If any
managed links (such as fw_devlink links) are present on the list, calling
device_link_del() on them will also trigger the WARN in
device_link_put_kref():

    static void device_link_put_kref(struct device_link *link)
    {
            if (device_link_test(link, DL_FLAG_STATELESS))
                    kref_put(&link->kref, __device_link_del);
            else if (!device_is_registered(link->consumer))
                    __device_link_del(&link->kref);
            else
                    WARN(1, "Unable to drop a managed device link reference=
\n");
    }

Should rockchip_drm_match_remove() instead iterate the sub-driver devices a=
nd
call the exported device_link_remove(dev, d) helper (or track the
struct device_link pointers returned by device_link_add())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025346.1527=
550-1-vulab@iscas.ac.cn?part=3D1
