Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DE3CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5848010E690;
	Mon, 12 Oct 2026 21:22:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA1110E690
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=I3KrjdeV0UiA+30eca2NC+dO4LthERlcCwBIkYYAoKU=; b=MJQ6uszvkqQtRc031WMjaNOvn3
 eoJ2JVpL3/0wvJsEaIoyk6gEiz21FPB7BgaDCb2GCsbPVEEhsOSRclgUvR6l/BCUdS62QWLQ0aRGe
 TcKI7SghRC2XEN3cLMuS1qd7WUZUBbptYeBbXuaLVU34uLWjrp6DGM0QsQFtlKGAy3O7zJqx6DFkC
 0BcEQkx2WnoIEcxP8hTTWr2PirXuVHGPU/KxnotcD117xnNU2h1MiBUKkHdQfYMMDnqWRbLtQ7KYD
 Im69pvKgcgJgaSLxmdwwTbyRHPl5BxshjmVOpTxUKUNU8f6+aACZYNbkRuSLNSJNx9s8JYQfEAVLr
 RpICV0gg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] accel/rocket: Fix use-after-free in
 rocket_ioctl_create_bo()
Date: Mon, 12 Oct 2026 23:22:13 +0200
Message-ID: <5113180.GXAFRqVoOG@diego>
In-Reply-To: <20260917180013.2166025-1-vulab@iscas.ac.cn>
References: <20260917180013.2166025-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

Am Donnerstag, 17. September 2026, 20:00:13 Mitteleurop=C3=A4ische Sommerze=
it schrieb Wentao Liang:
> If drm_gem_handle_create() fails, it takes and then releases its handle
> reference internally, leaving the creator's reference as the only one
> held.  The drm_gem_object_put() then drops that last reference, freeing
> the object via rocket_gem_bo_free(), and the subsequent goto err makes
> drm_gem_shmem_object_free() run on the already freed object.
>=20
> Return directly on the error instead: the put has already released
> everything the function acquired at this point, so there is nothing
> left to clean up on the err path.
>=20
> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/accel/rocket/rocket_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index 91095d1b3066..521819041475 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -82,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>  	ret =3D drm_gem_handle_create(file, gem_obj, &args->handle);
>  	drm_gem_object_put(gem_obj);
>  	if (ret)
> -		goto err;
> +		return ret;

I'm not sure, which kernel-version you're on, but it seems this code in
question has been changed back in may in=20
commit f706e6a4ce75 ("accel/rocket: fix UAF via dangling GEM handle in
create_bo")  [0] .

Thanks
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df706e6a4ce75585af979aec3dcbdce68bc76306b


