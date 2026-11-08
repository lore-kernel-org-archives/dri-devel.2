Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94388606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/nVS26Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC08910E165;
	Sun,  8 Nov 2026 03:46:31 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4854410E0C8
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 03:46:25 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-67bf3c6654fso113815d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 19:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794109584; cv=none;
 d=google.com; s=arc-20260327;
 b=QT9tNgeNqFoKZwK87ldNxS8uNeJeyxcSkd2LX9uAzZ9hJtn2TYHT7KvMXiK7YnGdZ2
 8e/phy92FE07/Yk86x3J4BQnN6AicIJUtit0rKj6ncN1CKqnWB7MiIVI3+6bh0FJB34S
 cRo9InLZSArgUPn37zZ8ND8EEDTa60syUvPhg9a9R8h6meXe10ha2WYV7QGK171cbSwr
 d9c2grqlEZ1YJX+e5qK3avbIxo0kcEsDkeLWymPwlGft14A1w9DlW/LvYzNyF9FQmI8K
 7mdRLZyaZ23Ol5Z6RRT/w42FQENBRCMjcKCoHWK+O0wFhpZ81HweTuY7oagzvj/m3FYL
 NCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mwGWLAWLhd4acRs/22QrN9a6HRE6bKyPJ3bU28Dz5ng=;
 fh=5AHNeLWvBOEzGmUILUhTn1Sn3yWcRYhb6DaCSq03z1g=;
 b=Abr1Ummqs1O9rQl8LoSVrF1WYeSb6pXaF9/pyHmq0QJH4pbkFGkEMy5gYk2TRAHlzD
 Fh00BDKZo0mUv6jNWUpMLzsZvzmkUNHI285PiJqV40XDFJDgOEdC8RSXltbXl/IAdHv6
 oaOtJPijGNQ9JriJN2ohJoW50El0VZ6FuP6FW9v9IrjoUG55LivCEZPxpxeGkDurjhHs
 zAfgIhM2WiQPJd78tmqwAO6GpulJXDUiJG2MfWPKZzsVeMY6s4M7uwMAVnIC2eHPo232
 5pZoY9HWcma3n1Athku/fgE37a35ND4NMDpvvxBk98x28jmQkAAru+gQQ65m/yHJ4bzM
 jlKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794109584; x=1794714384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mwGWLAWLhd4acRs/22QrN9a6HRE6bKyPJ3bU28Dz5ng=;
 b=D/nVS26QOXIVuA36KTtIiDjjqPIFmP2GlGld4gJOVemRFm5xdnk/uG5VvLiACwsQac
 FFlOMmiUuDwWEX83dILqVxMFq1/2dx3U2/8k0fQtY7B9PB1G3i56jROT2jknSkG2xwAF
 t4PJzFKg39WRvcDcfW7yeLoSh++Z6v4gUXJWlwV+O/YmYogVdgbG36K8Nk+XaZXCXjra
 vDZyx1LI0qiti81dzGoWlvhzGy3Z0+PZ0qnv05UXRURT4WPre5bsSBhRpNOSOl855xch
 rRANahXpiwBr7FvYLftd9/5f0vVfybFy7Wqlr3ArwWqjuvjFjWuzBtmvXCQ6YPcKv7cG
 PzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794109584; x=1794714384;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mwGWLAWLhd4acRs/22QrN9a6HRE6bKyPJ3bU28Dz5ng=;
 b=LXfNxMi+yRUGJZrB/LE/4aXY6LS1vJy7S2mmQtKz2KoUSSZt5Zp1OnXgLZ6XIhwic6
 bTy6ID1El3mdayEiVtPrRkqsjicAka3MtUz4PnYR6NWZ8NPTGZNheUrCfevfTYIzDUzE
 Pg6f90zRtjVXSwrX9hpJFC46g8OvMq9hG0rkRus+rgqNd1/AVDO6oV+vOzzD3mMzVSfh
 mwycUiawMZ1pdOmsGawxfxZQqPeivMzRX0XJv1/H3XnzGNdRm70XuPi5/DD+TA2KP0R2
 aA4Fh2ivtLPGoyVJ4zMBveya7LPO7s3h+X+qmvoiZTAzcs9qRcb88DFBJXK0Sf0a7E+p
 l9+g==
X-Forwarded-Encrypted: i=1;
 AL+hErHCteX5V5K9Y1Z8yhoCBLn+AXNiWTbnjfYLnfvZV36zzN57PzGFJ81tZk6nL0AFXhuL/ab5A24VyBc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+fRpKR/9t7NmMSp5PXCGd/6dxw/StlAfY/YKctWlnEIDESxJAC
 KV2t4trAsMe1GR16CkZjQNsAgU+F+fgaS0P51tKPH4wtDX+urtYKNb7QnTQmELoMJfoTEkJWzpS
 SJfNL5CvEA4QY/BJctppUAyrMeBBq5w4=
X-Gm-Gg: AYBFou25JejSwqR3U1AGSyxVsVuBaYh5it99AhYrXaCnnWed/iqlFdZaOeKVc7xlu7/
 Q1+3TxqF5Uyma8KXKxZCSDX9nJrjsbpYKVkDLAose1ezxUSProNMciV4isAaiHDpYFuwTpQkFgr
 uH4V5xb3R7MkwDZaN5iBztY7yzxwvdrnkTbVYRGB31FiU3ze5MEC1hFlvmyQPv3yVCjbgnO33LQ
 JQp7NuMeWmPzBKm9gG1Y3KXzu3bFnx+OqSgBOZdyxgi7N0uLNMS6aI0yLDlHTGuzSb39Ud0KVcU
 pzsdRc6MJEaAMYci/VPHIRukcvjf4AYQ/SfrIqYmi4hiviO2AWYWCPQ6oxqR6FdIrsHkmBGnh5T
 VWqV7KZOmcRmnx6a/wQ5Z0E+8H34dvCwoytQa9N8=
X-Received: by 2002:a05:690e:4105:b0:67b:f328:267d with SMTP id
 956f58d0204a3-67c3d7b7539mr396607d50.22.1794109584001; Sat, 07 Nov 2026
 19:46:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
In-Reply-To: <20261105-fix-sparse-iomem-warning-v1-1-35c13069f271@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 8 Nov 2026 12:46:13 +0900
X-Gm-Features: AclHuK_ZxINUxblx6s00SElV5UJduoCpBR5BIabEhj-lLu95QLXBiv2fJIiVvgs
Message-ID: <CAKbEznvHw-0ovzz-YFnY5t58cCpYN0f+9Hywa53rgeX3nZzi5g@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: use appropriate poll function for
 non-iomem
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 frank.binns@imgtec.com, brajesh.gupta@imgtec.com, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luigi,

On Thu, Nov 5, 2026 at 9:26=E2=80=AFPM Luigi Santivetti
<luigi.santivetti@imgtec.com> wrote:
>
> pvr_power_send_command() checks the contents of some memory on the CPU
> that's written to by the firmware. readl_poll_timeout() expects the addre=
ss
> to read from to be qualified with __iomem, that is generally used for
> registers or memory that is accessed through a bus and other than regular
> system memory.
>
> For PowerVR in particular, __iomem is not accurate as the memory pointed =
to
> by can strictly be system memory only.
>
> Fix this by lifting one level of abstraction in the macro expansion chain
> and explicitly provide what routine should be used for reading.
>
> Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure =
and META FW support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610302136.3nli2ijx-lkp@i=
ntel.com/
> Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
> ---
> Use a different routine when polling for reading from system memory, in
> particular one that doesn't expect it to be qualified with __iomem and
> at the same time try not to change the timing.
> ---
>  drivers/gpu/drm/imagination/pvr_power.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f4..c7c160913d7c 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -59,7 +59,8 @@ pvr_power_send_command(struct pvr_device *pvr_dev, stru=
ct rogue_fwif_kccb_cmd *p
>                 return err;
>
>         /* Wait for FW to acknowledge. */
> -       return readl_poll_timeout(pvr_dev->fw_dev.power_sync, value, valu=
e !=3D 0, 100,
> +       return readx_poll_timeout(READ_ONCE,
> +                                 *pvr_dev->fw_dev.power_sync, value, val=
ue !=3D 0, 100,
>                                   POWER_SYNC_TIMEOUT_US);
>  }
>
>
> ---
> base-commit: c347fef5f8f8927985bd67835331ce4cf7ff43a4
> change-id: 20261104-fix-sparse-iomem-warning-2111c1e6dbed
>
> Best regards,
> --
> Luigi Santivetti <luigi.santivetti@imgtec.com>
>

The previous sparse warning is gone:
    pvr_power.c:62:16: warning: incorrect type in argument 1
(different address spaces)

Tested-by: Gyeyoung Baek <gye976@gmail.com>

--=20
Thanks,
Gyeyoung
