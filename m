Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E969606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=CAHB0lxR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F0C10E599;
	Fri, 23 Oct 2026 18:17:03 +0000 (UTC)
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC90112AA6
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792751828; x=1793011028;
 bh=o+ECcOPFP4Q0KHoI1iYU3bYydXUFN1HkYHahxH+riFQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CAHB0lxRMqXctul9TXuCz0SppNXysNmJcaeq10Yg/tKTyAyDV7KKpVnWsQjFX0c4E
 V1To/2drqTm1h4+kfmJLVEru2i2gn77PkBw/JZ6SyQ1GK5qIZLmAJHTRdPanBJXbid
 t6eAfFm1eZlRBwal6wtpl2mg5gGeF1TMczX9aFfQFXsEIvE0IyBiQsMQoUB1PLhdd3
 fGd4u2wk92wliOcoU0bMMY7AkYDurVjdLLcqtAlrGbzHCs2NM1PMz6LHhLAKZs9e0A
 eGCSYzeRU0vJBosjL5lWafE4H8XETUjQiwlcf4mqiedDug5zYENrTPoRe8fwNci39O
 Pv+mUk34E8xrw==
Date: Fri, 23 Oct 2026 10:37:00 +0000
To: Max Zhen <max.zhen@amd.com>
From: Umio-Yasuno - coelacanth_dream <coelacanth_dream@protonmail.com>
Cc: ogabbay@kernel.org, quic_jhugo@quicinc.com, lizhi.hou@amd.com,
 dri-devel@lists.freedesktop.org, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
Subject: Re: [PATCH V1 1/5] accel/amdxdna: Use compatible fdinfo engine key
Message-ID: <qAXy4UirzgL1y5Voy73b1qQ5-Fa_UPNl--88ahgTxRsSyCIv3DNdH5BuSoBYG-i6TTNzXl9RtS32KGeXaLvghgM39yNrAUFq5_ZG9d9w5Tc=@protonmail.com>
In-Reply-To: <20261022155753.232976-1-max.zhen@amd.com>
References: <20261022155753.232976-1-max.zhen@amd.com>
Feedback-ID: 19510729:user:proton
X-Pm-Message-ID: cbb43f3610f25222a2e032b5542edb11435266fd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Friday, October 23rd, 2026 at 0:58, Max Zhen <max.zhen@amd.com> wrote:

> The released out-of-tree amdxdna driver uses amdxdna_accel_driver as the
> drm-engine key string, which is consumed by several applications.
>
> Use the same key string in the upstream driver to maintain compatibility
> with the out-of-tree driver.
>
> Reported-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> Closes: https://github.com/amd/xdna-driver/issues/1754
> Fixes: 489a8539ca6f ("accel/amdxdna: Expose NPU device busy time via DRM =
fdinfo")
> Signed-off-by: Max Zhen <max.zhen@amd.com>

Reviewed-by: Umio Yasuno <coelacanth_dream@protonmail.com>

Thanks!

> ---
>  Documentation/accel/amdxdna/amdnpu.rst  | 2 +-
>  drivers/accel/amdxdna/amdxdna_pci_drv.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel=
/amdxdna/amdnpu.rst
> index d72af1b51ccf..b0cc481c73ae 100644
> --- a/Documentation/accel/amdxdna/amdnpu.rst
> +++ b/Documentation/accel/amdxdna/amdnpu.rst
> @@ -289,7 +289,7 @@ Example of the output showing the implemented key val=
ue pairs:
>          drm-driver:=09amdxdna_accel_driver
>          drm-client-id:=093219
>          drm-pdev:=090000:c5:00.1
> -        drm-engine-npu: 14003870 ns
> +        drm-engine-amdxdna_accel_driver:        14003870 ns
>          amdxdna_accel_driver-heap-alloc:=0960 KiB
>          amdxdna_accel_driver-internal-alloc:=0967588 KiB
>          amdxdna_accel_driver-external-alloc:=090
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index edf807c93144..f233eb70a295 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -284,9 +284,9 @@ static void amdxdna_show_fdinfo(struct drm_printer *p=
, struct drm_file *filp)
>  {
>  =09struct amdxdna_client *client =3D filp->driver_priv;
>  =09size_t heap_usage, external_usage, internal_usage;
> -=09char *drv_name =3D filp->minor->dev->driver->name;
> +=09char *drv_name =3D "amdxdna_accel_driver";
>
> -=09drm_printf(p, "drm-engine-npu:\t%llu ns\n",
> +=09drm_printf(p, "drm-engine-%s:\t%llu ns\n", drv_name,
>  =09=09   amdxdna_io_stats_busy_time_ns(client));
>
>  =09mutex_lock(&client->mm_lock);
> --
> 2.34.1
>
>
