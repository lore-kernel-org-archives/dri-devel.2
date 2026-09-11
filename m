Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFBEC88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6DA10E9C6;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SzZkNMSW";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5930E10E088
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:32:27 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a9a4dc8afeso1682797a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140746; cv=none;
 d=google.com; s=arc-20260327;
 b=JkoX1Z/YFMNP7ZvK7zqURNUspYUZAlTu1ipiHnhPU1KHyN8GIEzDGksB0hg9FC2nos
 WNKuk1eWNMFme5cBgF8prfQyIe6OsrO4poqQCDymH/nP9sAGFjT+Apk7lowfN3KMrEv2
 2lRSJTkRJYyF7p+/VN4iRtavvCiRsDWl1JgA22f7R+mDmV66os0Sa3YmmH5VOKwe/B9H
 NfrDXNC7IT7IPnbANKDEaGbf2UMmGXyjd2MKWMO5RQJtMch3mtxWtb58mW1quCBqdSXS
 cMF4lFohfwQA6yfxPNJLJd5OIxMdP6cRZE3t3x+IIv/OkfUMKztNyegbNdnUMRNdgh1/
 usPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
 fh=MjdxHEhOBoaGU2fupkPEWgMw3WO7pM4k51T4PEC7NdA=;
 b=bDQwMqZPMH80nC6py7k7ICaxvq+3VVs+lgSVhGOs4QH+4KPbjjX9t+c7jSavhjbzIO
 ky7KnFEQaJ9d6rQc106WpEu08KdB94XXSXoWJZACpw+KTVnmYhWNfA6EwFVTUYtfQdS7
 E8NRB/UkNakhigGYis/+gLH2mtb0VfGAIgstsrkNkC0dFSRqO1XkyjpyZdqiNQqNoaR3
 iRTcyhubag43pznTAFtCfv3u66AThjyVQUEyt1OKl9AaxLCgxcR9QlXLzFI1Rf/pdycw
 LRvji1OkeHXE9hJ8cxlmhmH05f7AxTG8Y3T3mQMjKkNEVz0dC/dJcq8u8Np/2T+EdJ8v
 ez5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789140746; x=1789745546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
 b=SzZkNMSWlOkusIVD0Tt6B03XLzxBPqoNeB5OJrCZ8eUDfF3cU1k0qvn9GwO2UXw3GQ
 IZBlfWd5PxgIGDFBDhe2GS723fd7vmfsFS4NHfWQFwtdGlGlOSXD7stT+SPbUm9A/nM9
 tCF8jntFS8A5AdLaAkbA1l3ON6NoVH1wIExbPY4CE0ZJNyDqXe0wr28Iz0TxDu4oxTMh
 Y0VyKRJi+TPxDV9bbJYgVBvVLnVYO4KrA52sR7tOAkiPq2eobHTRl3yR+oIvv1mZ6fJl
 purzuLYAJ7UoKjP12dgbNsWSUntJe9d6TMx1dtoujohLUa/bjUMcy3rtO3XUSip+PjCi
 NjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140746; x=1789745546;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jfN2aS/+tGG4m/Gr1t61ow0ODqlfB2pmuz3SNqMPHwA=;
 b=gH//mSZJ4s9gsTY6ny3tyqN1SeDeXeES2Q2JHIuUbYA9zfqPtGQSxsYxRi29NjQzqF
 9C8d682UbeTelG5ASwbW6L4lIRvfOEvmrhy0eps36qj0c04FfoRTZwVl4xW1wrJfel36
 QgOJBLjx10s3y9f1zO/QJVWEue9pgxqdLKDGxoqAnvjnlRAhOPrNYt9t/aFRYen/nUtp
 mSANxVwHzKQZHeqZAFhLrd3PoaMkg6s9QtOCDe6/xlyl3VI0w+QnNriLZ3+N15te8D3h
 Qug/vJv8aRLUxgEze2UEx/hDPSsAeDwHIa9G/7Okg9P8R5U8VMsysiAm2dJFWL5JMV31
 APlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5NOaoeg5zc+ez50XT5s4kUqMa9/dQJgWQzks1MAKblH5n7IBmWZSd5PfrBG1DaAU7AJPVXIXcfwo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m9F6DgGxn64Xfxk6SgKa1KgHO+40G9prN+i6iJuUC/UwvFj/Bz
 CxxnEVj4CuUdEvJjs+92l4DMBmhA8oqOYC1A5yAd6u9xmzoZsKyf0eTzaQ+UboCt3R+Oikm2549
 A8NG8+Mn39wqTWppBZk+RMnvF9tOWwaY=
X-Gm-Gg: AYBFou3+/ztxUMwNymQK1dChVm8M3b4w4kI7mp0hjdiPIc064cun7cGstvPU+nHtzN6
 psaKdpr85I7uC7M1FDRSd9P8Sjji0L6lhp8u/9CBfEpF7CPPJteNT9Ud/zGal1tFsrkptV5SrQF
 NIEXgK59t7wH+hwklqirFKZLMDWgtMvHti+x3rH1sI59nmnf1UlOb3CQT7QFhSyJkl6elTlbCef
 xXj0QmjA37XWgbXtvbUbGNA+ZMZHVHVX/iNjkjPugfFQ/3Fq/U+HGb3y/ZW2LBrhP9vi+XFN7Y1
 jeyLTh4uoIpTq7HLLT6iDGL0ejE5lX9QAMdE6vpbo2kUDb5F1kvUltuK//c71DIumHLKPGd899J
 hEHG8F/6RjxGxMw==
X-Received: by 2002:a05:6402:518c:b0:6a7:ee54:f897 with SMTP id
 4fb4d7f45d1cf-6a9b56a48c9mr2177348a12.27.1789140745444; Fri, 11 Sep 2026
 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Fri, 11 Sep 2026 08:32:12 -0700
X-Gm-Features: AcwNN1V_cGfwO5j1Bxt8GNsLjTC8MCOtlSabaRFMfY5X1VvYPK3yIDdCB9APKfE
Message-ID: <CAJ+hS_j5w1sfpLS91HC_dSDgdK-=0z3PemY51hUbJVLW-wyF1g@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers when
 3D is enabled"
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Val Packett <val@invisiblethingslab.com>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:14 +0000
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

On Fri, Sep 11, 2026 at 7:42=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
> blobs, and thus, further 3d operations with the imported blob are failing=
.
> Typical scenario of the problem shown with mouse cursor RGBA image import=
ed
> into virtio-gpu, which previously was rejected by virtio-gpu driver.
> Revert enabling guest blobs importing into vrend to fix the regression.
>
> Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
> Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D i=
s enabled")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/vir=
tio/virtgpu_prime.c
> index 149e6bcb5878..ebf471044d06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -349,7 +349,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struc=
t drm_device *dev,
>                 }
>         }
>
> -       if (!vgdev->has_resource_blob)
> +       if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
>                 return drm_gem_prime_import(dev, buf);
>
>         bo =3D kzalloc_obj(*bo);
> --
> 2.55.0
>

r-b. Thanks for the prompt revert!
