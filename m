Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A22FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552D210E1A3;
	Thu, 30 Apr 2026 11:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="IVJoOecY";
	dkim-atps=neutral
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7345B10E18E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:56:32 +0000 (UTC)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso433694a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 04:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777550192; x=1778154992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARswXigYf+mz5/Jbm3xEvOI0YCBqmKu6gmUHqHfx2JM=;
 b=FRRKHqCBAZYZ9CcoDq+ahDPLbXdYUvamEBHkEIGCeC7qSwSyHTKV0T1m/Mq8zMvsUv
 RctN/229rLjGbcMJMIzMi1AIpZo9+fKflx6ApTsGKu+9VNGvUKNoEojpD04ZnB9/CGby
 l52NqFSsDbKOfRxrlO6oN+tbpmTjEwPY/lGlAANAIpsUyf427UVmKTn77N2UmXgTkdl1
 YneB05hgqUhVH78nT9cAE1P4W1ZFRYP84ERzv8B3UhLlIAeGp4naF0TqiIZb0tQu0jZO
 DzIHdEwiIscGsnowlyFgp2mmYGWHk6Awv9fQdu4Hj47gFeThY2sAZwGYGfQPMzaWAg0v
 Z0mw==
X-Gm-Message-State: AOJu0YxW/mWUo7ZpveurmON9QAHiLSZgf1Rkz8Bc6jpYtwNW2VIKP+Z0
 bsg6jNXf2svokpOptccZjH5zWhtFVFRl5z7I09VzwgouE647ZVRYRGrBEwmeg7huwBZ1IFcQs/j
 HoYKGnQOlCTmTD+8KkLdhSnGPOm66vo0J4WWnSCbBo9TK/kDtIAT7jyQxLrKLiyABmb8B/KBM4E
 N1jlUF/f+hzW4zmJ6ZmkS4uHPPoOziK8SyoSkoc4WyBhAtMfkcKP2wsiQhc82V8BcCPnidFPPlf
 tHfdssJWSn2DwGPcEtG
X-Gm-Gg: AeBDiesiHH4oVv174Yoy7Ey+iTGmJ4nL5fNc25COBXza4ze97YN/cWsTIBv4B+MSzd6
 o6jbKdz8Hbze2zbotHZ5jAWW6lm2IyGyxODFKrUvtWPHeMrMXI4yr4U+lCkSNSMrT5mm8iiho83
 umdNdVDKDW+e3hv/ZYLYVS74NWhyB+5/CVQ8VD+EoUz1Gz9rv+mco+wfbiXjs/iI7RLSrY7GIEA
 Y707fo0yKcw0zAGi6YbLEV4AI3/CuSSvJfkyRk7NNGRSGE9dTXhGSH7wX3u/H/Od1YI0iA4cygS
 USlMv3vJJnsTZ1jdCWESJOIAYLsdDCfohNJE13Az1/lq2DS8xts1XnjxF+4E7EBmPqrPdK8uR//
 gTZ5pnZkxLn9JHrCqNtv1hCnHkT1wHpY2whyzTbiO98wmrI4aIAb3CEfLiAH5/bfLzcKy398xG7
 8uSy03/DOI5iqY
X-Received: by 2002:a05:6830:380f:b0:7d7:e6cb:836f with SMTP id
 46e09a7af769-7deba2c5ef5mr1469061a34.19.1777550191492; 
 Thu, 30 Apr 2026 04:56:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7deab7cd8b7sm470528a34.2.2026.04.30.04.56.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2026 04:56:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a2c40819cdso461908e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777550187; x=1778154987;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ARswXigYf+mz5/Jbm3xEvOI0YCBqmKu6gmUHqHfx2JM=;
 b=IVJoOecYC4VRvZuc8Yj2At8WNjwszGAMvYVIi476EL25IclXcTwwPpGhwtCWC9zRgw
 oQtJNjb60PFBfoe2uDu8kJyApdXrj3fEfTNjhu7lUGmbJkpR/CdcEd3GQcse0IO1P01o
 nkRUiJ/XAey0hpliL3mMtvQ6FAMoWAS63D1kM=
X-Received: by 2002:a05:6512:2208:b0:5a3:ff48:f7d6 with SMTP id
 2adb3069b0e04-5a85272b2cbmr732195e87.13.1777550187512; 
 Thu, 30 Apr 2026 04:56:27 -0700 (PDT)
X-Received: by 2002:a05:6512:2208:b0:5a3:ff48:f7d6 with SMTP id
 2adb3069b0e04-5a85272b2cbmr732184e87.13.1777550186976; Thu, 30 Apr 2026
 04:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
 <20260430001913.482967-4-maaz.mombasawala@broadcom.com>
In-Reply-To: <20260430001913.482967-4-maaz.mombasawala@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 30 Apr 2026 07:56:11 -0400
X-Gm-Features: AVHnY4JBI6JqZev3jK6kX8VjRQCFBG6QpjmPJGcSiYIVjk3yyM_SSZK7Ek_OPQ0
Message-ID: <CABQX2QO+3PORjJodGr_a2z-SieRvWFxJA7D_8TPfp8Z90QXc9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 ian.forbes@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008456140650ac27be"
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

--0000000000008456140650ac27be
Content-Type: multipart/mixed; boundary="000000000000775a3f0650ac271f"

--000000000000775a3f0650ac271f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 8:17=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> wrote:
>
> Preserve a ttm reference during dumb buffer creation. This keeps the dumb
> buffer valid for framebuffer usage and fixes all igt tests that use dumb
> buffers.
> One tricky case arises in the igt test vmw_prime@tri-map-dmabuf, in which
> the gem buffer backing the dumb buffer is prime transferred and the
> vmw_surface which is referenced from the prime handle. In this case a
> reference to the gem object from the surface remains persistent and cause=
s
> a memleak.
> Fix it by using a separate refcount_release() callback for the dumb buffe=
r
> surface which puts the gem reference.
>
> Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 31 ++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index b2d3927b5567..c600983aa571 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -2220,6 +2220,31 @@ static SVGA3dSurfaceFormat vmw_format_bpp_to_svga(=
struct vmw_private *vmw,
>         }
>  }
>
> +static void vmw_dumb_srf_refcount_release(struct ttm_base_object **p_bas=
e)
> +{
> +       struct ttm_base_object *base =3D *p_base;
> +       struct ttm_prime_object *prime;
> +       struct vmw_user_surface *user_srf;
> +       struct vmw_surface *srf;
> +       struct vmw_bo *vbo;
> +
> +       *p_base =3D NULL;
> +       prime =3D container_of(base, struct ttm_prime_object, base);
> +       WARN_ON_ONCE(prime->dma_buf !=3D NULL);
> +       mutex_destroy(&prime->mutex);
> +
> +       user_srf =3D container_of(base, struct vmw_user_surface, prime.ba=
se);
> +       srf =3D &user_srf->srf;
> +
> +       vbo =3D srf->res.guest_memory_bo;
> +       if (!vbo)
> +               return;
> +
> +       BUG_ON(!vbo->is_dumb);
> +
> +       drm_gem_object_put(&vbo->tbo.base);

Did you try running this with KASAN enabled? Because this put looks
unbalanced to me and should cause warnings. It looks like you're
undoing Ian's rework of the reference counting.

For this I'd try to keep gem reference counting as is. We don't want
to change ownership strcucture there. I think what we want is to
probably make sure that dumb buffers own
their surfaces. Can you try the attached patch?

z

--000000000000775a3f0650ac271f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-vmwgfx-Keep-dumb-buffer-surface-alive-for-PRIME-.patch"
Content-Disposition: attachment; 
	filename="0001-drm-vmwgfx-Keep-dumb-buffer-surface-alive-for-PRIME-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_molff6m00>
X-Attachment-Id: f_molff6m00

RnJvbSBkYzBmMDZlYzE0YWU1ZjFmZmE3NTM4OTFkZDIzMzBkOGNkODZjYmE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaYWNrIFJ1c2luIDx6YWNrLnJ1c2luQGJyb2FkY29tLmNvbT4K
RGF0ZTogVGh1LCAzMCBBcHIgMjAyNiAwNzo1MTo0MyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS92bXdnZng6IEtlZXAgZHVtYiBidWZmZXIgc3VyZmFjZSBhbGl2ZSBmb3IgUFJJTUUgZXhwb3J0
CgpEdW1iIGJ1ZmZlcnMgYmFja2VkIGJ5IGhpZGRlbiB2bXdnZnggc3VyZmFjZXMgbmVlZCB0aGF0
IHN1cmZhY2UKdG8gcmVtYWluIGxvb2t1cGFibGUgZm9yIGFzIGxvbmcgYXMgdGhlIEdFTSBCTyBj
YW4gYmUga2VwdCBhbGl2ZQpieSBhIGRtYS1idWYgZXhwb3J0LiBUYWtlIGFuIGV4dHJhIHJlZmVy
ZW5jZSBvbiB0aGUgc3VyZmFjZSBUVE0gYmFzZQpvYmplY3QgZm9yIHRoZSBkdW1iIEJPIGxpZmV0
aW1lLCBhbmQgcmVsZWFzZSBpdCBmcm9tIHRoZSBkdW1iIEJPCnRlYXJkb3duIHBhdGgsIHdoaWxl
IHN0aWxsIGRyb3BwaW5nIHRoZSBwcml2YXRlIHN1cmZhY2UgaGFuZGxlIGZyb20KdGhlIGNyZWF0
aW5nIGZpbGUuIFRoaXMgbGV0cyBQUklNRSB1c2VycyBpbXBvcnQgb3IgcmVmZXJlbmNlIHRoZQpl
eHBvcnRlZCBkdW1iIGJ1ZmZlciBhZnRlciB0aGUgb3JpZ2luYWwgR0VNIGhhbmRsZSBpcyBjbG9z
ZWQgd2l0aG91dApsZWFraW5nIHRoZSBmaWxlLW93bmVkIHN1cmZhY2UgaGFuZGxlLgoKQXR0ZW1w
dHMgdG8gZml4IHZtd19wcmltZUB0cmktbWFwLWRtYWJ1ZgoKU2lnbmVkLW9mZi1ieTogWmFjayBS
dXNpbiA8emFjay5ydXNpbkBicm9hZGNvbS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfYm8uYyAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhf
ZHJ2LmggICAgIHwgIDIgKysKIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3N1cmZhY2Uu
YyB8IDE4ICsrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfYm8uYyBiL2Ry
aXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmMKaW5kZXggOWM3YTczYzBiMGRjLi4wNTdj
ODkwNzlkOGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfYm8uYwpAQCAtNjYsNiArNjYsNyBA
QCBzdGF0aWMgdm9pZCB2bXdfYm9fZnJlZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQog
CQkJCQkgICAgICAgMCk7CiAJCQltdXRleF91bmxvY2soJnJlcy0+ZGV2X3ByaXYtPmNtZGJ1Zl9t
dXRleCk7CiAJCX0KKwkJdm13X2R1bWJfc3VyZmFjZV9iYXNlX3VucmVmZXJlbmNlKHZiby0+ZHVt
Yl9zdXJmYWNlKTsKIAkJdm13X3N1cmZhY2VfdW5yZWZlcmVuY2UoJnZiby0+ZHVtYl9zdXJmYWNl
KTsKIAl9CiAJV0FSTl9PTighUkJfRU1QVFlfUk9PVCgmdmJvLT5yZXNfdHJlZSkpOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmggYi9kcml2ZXJzL2dwdS9k
cm0vdm13Z2Z4L3Ztd2dmeF9kcnYuaAppbmRleCA1NzQ2NWY2OWM2ODcuLmI1YTJhNDQ4ZjhmMiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmgKQEAgLTExODYsNiArMTE4Niw4IEBAIHUz
MiB2bXdfbG9va3VwX3N1cmZhY2VfaGFuZGxlX2Zvcl9idWZmZXIoc3RydWN0IHZtd19wcml2YXRl
ICp2bXcsCiBpbnQgdm13X2R1bWJfY3JlYXRlKHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2LAog
CQkgICAgc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAkJICAgIHN0cnVjdCBkcm1fbW9kZV9jcmVh
dGVfZHVtYiAqYXJncyk7Cit2b2lkIHZtd19kdW1iX3N1cmZhY2VfYmFzZV9yZWZlcmVuY2Uoc3Ry
dWN0IHZtd19zdXJmYWNlICpzcmYpOwordm9pZCB2bXdfZHVtYl9zdXJmYWNlX2Jhc2VfdW5yZWZl
cmVuY2Uoc3RydWN0IHZtd19zdXJmYWNlICpzcmYpOwogCiAvKgogICogU2hhZGVyIG1hbmFnZW1l
bnQgLSB2bXdnZnhfc2hhZGVyLmMKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngv
dm13Z2Z4X3N1cmZhY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3N1cmZhY2Uu
YwppbmRleCBiMmQzOTI3YjU1NjcuLjk5OTVjNzM0Zjc1YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3Ztd2dmeC92bXdnZnhfc3VyZmFjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92bXdn
Zngvdm13Z2Z4X3N1cmZhY2UuYwpAQCAtMjIyMCw2ICsyMjIwLDIzIEBAIHN0YXRpYyBTVkdBM2RT
dXJmYWNlRm9ybWF0IHZtd19mb3JtYXRfYnBwX3RvX3N2Z2Eoc3RydWN0IHZtd19wcml2YXRlICp2
bXcsCiAJfQogfQogCit2b2lkIHZtd19kdW1iX3N1cmZhY2VfYmFzZV9yZWZlcmVuY2Uoc3RydWN0
IHZtd19zdXJmYWNlICpzcmYpCit7CisJc3RydWN0IHZtd191c2VyX3N1cmZhY2UgKnVzZXJfc3Jm
ID0KKwkJY29udGFpbmVyX29mKHNyZiwgc3RydWN0IHZtd191c2VyX3N1cmZhY2UsIHNyZik7CisK
KwlrcmVmX2dldCgmdXNlcl9zcmYtPnByaW1lLmJhc2UucmVmY291bnQpOworfQorCit2b2lkIHZt
d19kdW1iX3N1cmZhY2VfYmFzZV91bnJlZmVyZW5jZShzdHJ1Y3Qgdm13X3N1cmZhY2UgKnNyZikK
K3sKKwlzdHJ1Y3Qgdm13X3VzZXJfc3VyZmFjZSAqdXNlcl9zcmYgPQorCQljb250YWluZXJfb2Yo
c3JmLCBzdHJ1Y3Qgdm13X3VzZXJfc3VyZmFjZSwgc3JmKTsKKwlzdHJ1Y3QgdHRtX2Jhc2Vfb2Jq
ZWN0ICpiYXNlID0gJnVzZXJfc3JmLT5wcmltZS5iYXNlOworCisJdHRtX2Jhc2Vfb2JqZWN0X3Vu
cmVmKCZiYXNlKTsKK30KKwogLyoqCiAgKiB2bXdfZHVtYl9jcmVhdGUgLSBDcmVhdGUgYSBkdW1i
IGttcyBidWZmZXIKICAqCkBAIC0yMzI4LDYgKzIzNDUsNyBAQCBpbnQgdm13X2R1bWJfY3JlYXRl
KHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2LAogCXN0cnVjdCB2bXdfdXNlcl9zdXJmYWNlICp1
c3VyZiA9IGNvbnRhaW5lcl9vZih2Ym8tPmR1bWJfc3VyZmFjZSwKIAkJCQkJCXN0cnVjdCB2bXdf
dXNlcl9zdXJmYWNlLCBzcmYpOwogCXVzdXJmLT5wcmltZS5iYXNlLnJlZmNvdW50X3JlbGVhc2Ug
PSBOVUxMOworCXZtd19kdW1iX3N1cmZhY2VfYmFzZV9yZWZlcmVuY2UodmJvLT5kdW1iX3N1cmZh
Y2UpOwogZXJyOgogCWlmIChyZXMpCiAJCXZtd19yZXNvdXJjZV91bnJlZmVyZW5jZSgmcmVzKTsK
LS0gCjIuNTEuMAoK
--000000000000775a3f0650ac271f--

--0000000000008456140650ac27be
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJoM
3acjm5HTo9Bbmos5Khf+WmBY+gVCmq5Mu3Norb38MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQzMDExNTYyN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI6n2y/T/U97FyTLqhx95f1uGR6TtPbt8BUMWfUT
1Ae3gZxhd9JUOdbOHtfHEgZsm+zH4ixade6y4Ili1zc1FF/qrlBftyl37XZKnJ6wDZyDdISqP6J9
bT0uYKcnOh3dph8nlg6hNSuYRcfUO+sRvtU3+2vApfIhfiNrv3VkTSkogf8HUmbLSITEiqba6S0+
xqI7gu/0o8R9OpGj5H3+ewm0UuqsxB/pJnuOnUoVGgTY/ntYIaFFQhetegarBl4FfMmqtT+Ejqw9
hXYlIZQrMSAMXkXGWXWPSe7Zoucx9TXrKcAWM/BzZytkv/DNHzG2CviCDmoTfedLdIUXBZsm0IQ=
--0000000000008456140650ac27be--
