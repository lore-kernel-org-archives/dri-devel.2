Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FAEF433DD
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 03:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DC310E7EF;
	Thu, 16 Apr 2026 03:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="WOpzgLVI";
	dkim-atps=neutral
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com
 [209.85.222.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3188810E7EF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 03:37:59 +0000 (UTC)
Received: by mail-qk1-f227.google.com with SMTP id
 af79cd13be357-8c70b5594f4so28606385a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776310678; x=1776915478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XndGAmqap9ZGaweV6gk2dWDpB66xitKF2pkvQWt1+0I=;
 b=GEngTbw+mpauJRYNWOVMD45TzP3PYhS1vg1hamDs/bQgSz1LViL2GeYQ3D00Ih3z/J
 dquH1I0Ol/4clRrZ6AODzqT/sTvOlO83FaycPXsAJ5pUgQwxIr/cQUvVE/Oa7A+IoakN
 DwJLojayU6Lji+piZEEf/QHUBk2bZaR2k8dNdyn8whe4XkeJKg0UDkfuqEFMdDNbBUCi
 /G3Ue3lKhIYq9uY3QmBJdYs6elm74qtECtAFS/2TB9YW4IXx3SJTWRuAsxOVcjAN/KMy
 whTStkzw8k+kcDoINGmsLGpe7/GzB4lUtWc6qpvKvJDVZCnG1+G6rNdCIv3D3QETVetJ
 ovBA==
X-Forwarded-Encrypted: i=2;
 AFNElJ9U9Lijq0N1vnPq0MTfV4bNCZnCDCKTxF5rz5xVlGDVzCOJTlo8GxUnQ0x+IQOPzrQPsLqufBvyG7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRgpSxUnvQP77wo1OXij/vbjQHU61hCfSDrcdM1l3KiNPvLK4Z
 gI+rejGp2ENWqbByK5MaocfMhkjd2lbV1zrr1OTpzs85wGmM35sg4+v0ZwvqbvK2qWafrNT1Bb4
 CI81qS+WOHCWudaQAVShzVuTavYPd4sEMWFNMZyhkwyyDMPOuNNfpJE3jj8PgZO6+fQpD47/9zw
 EW31FFA0bs42zaaJU7R8GaL4feiZIioWKKLmtLzTj+YWaQW8zY3yMs1J/w09Ahiza5K9c7uTpbH
 jvkXET0tn/Otsq0tLF0
X-Gm-Gg: AeBDieuevJRTxHQc8bnI3p/7/DAJOkbueCXexd5+F58Ty0TqJuSLOiZhcBbgUZdkxZO
 c1dPYa/C+WHSaweWvhwKT+shExmTh18gOpcFB6KjDKccarFwIA0ps//rN7XWdnwXQLWx7u+6pOo
 PwaLKuIgmlpHQv2VKDHcZtqdD5eR7dAiyhw+Rtnajz1iG3h2yuL/skDhEZXdMX/MFun1b63qExB
 QTWqybV3qinJTbcW2/2xNSR+U6CUteyAREzI5U8gjQIXmmuSuR00Cis3vun2tlSZhxflXAfMjOH
 RrCoXPeeI2a+ly4EItaQqKm6rLN0CMZ9/KlDWxMmyzj1998dAZsY2EWDpi+W7Xd+gvUTHYi0TjE
 ylY5EV9FRYkyQSKMhKUzpAbLWDsO+ERv2Azggd3rVD4YsLXc2U/SM+hXUcTOE7K6p8mT86SH7bc
 5Y0apc+UrNL0gmX/dzlYYfmzvvSTCMdchoTC147q4q48VNBFIyCpN6gLxApDmPgzLeWBw=
X-Received: by 2002:a05:620a:2556:b0:8cd:85e1:e214 with SMTP id
 af79cd13be357-8e5de573a23mr311006785a.37.1776310677763; 
 Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-8e4f166007fsm20885285a.5.2026.04.15.20.37.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59e28288067so6889145e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776310676; cv=none;
 d=google.com; s=arc-20240605;
 b=gQtLFUWYh9rzQ+Zd8X2mR43U+BUyKStazVo9pZl1UwpAn0eKMnZJ3YV4be1kCvqdMm
 ly5mAa6s6/LHAMoZ3bdAURbhnz4NvHWy89iw/1XDoKCmeWWOy+J6VfEtwdlxHgO9PbKK
 96lBtMRIbkKEfdXvleLIsLK052dfD45Ali6pyB++A7+i6VA04Cbx7PAZH3WW2b9NMpW4
 RxrevTYZN/qCJgTVolSY4xmHmqx62tX1a8gin/NEd24r12IyDtwM9w9+YUM97I5wWdmk
 TcSH+eukCVtAk1OKVICpsDvN1nSHELOKjs47QiFh2DJFOoAb5RPz0Huwgz5anlYreIQk
 8SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XndGAmqap9ZGaweV6gk2dWDpB66xitKF2pkvQWt1+0I=;
 fh=BDIDNFMvwiK9AKZmuxV3TsMXwZibCEUuQo2BFRHm1uc=;
 b=ROSOQw6pXJiPADhCE1hn3VPlKIt+8SnLnzoyTy/B3bZYlFcmfaGCyTHvrRY+YFRuqD
 cpnFL3CzKgMVmyyg4iqwlA4Lp+TOA7aRDjsJEvHBdRTrvY+N0xmjarX3TvYOolN7Rd0p
 B6l9D8NCvMFHwU01fKtXlGeE6TwHQcm2dowmTNaXNDd5rkCjT79oC4222TjgQbEeQADA
 s3sKP9a0ciSZSUC1CylVhGttlydleuso3XOVpT5N+lEveUpNOyLPfzay7NOIBthELGfK
 rOfpGUldUky7Nqp4GWyKOyCUp+O+3QaaatbCq4iZrsOKNKf881nqfHI6i4AAPGRYhez7
 GDXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776310676; x=1776915476;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XndGAmqap9ZGaweV6gk2dWDpB66xitKF2pkvQWt1+0I=;
 b=WOpzgLVIUp+TfA0jIrNheedrcai1y4WOqDpV1qSTZs4MFY41Ey+ubgJT8N6Ym4R2Dr
 zuteP4HvZXXK8XKq3cjepdShvEVo95giW3D3HAEw4VWVyALGKXOsDzwYzxtJ9OuP38qe
 7X+FeBsAW6Jj2iaQ1LNUpsQJpjFm6sbYb0Wnw=
X-Forwarded-Encrypted: i=1;
 AFNElJ8d/K5cPocs0zE34n94eAVhGLwTnTqD1N3GetlUW7u2/1kdAdr1uwLVLgvPVmerVaOFsMp2kk+hKkA=@lists.freedesktop.org
X-Received: by 2002:a05:6512:3e28:b0:5a2:ad98:3685 with SMTP id
 2adb3069b0e04-5a3efd90bbfmr7195879e87.35.1776310675875; 
 Wed, 15 Apr 2026 20:37:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3e28:b0:5a2:ad98:3685 with SMTP id
 2adb3069b0e04-5a3efd90bbfmr7195870e87.35.1776310675337; Wed, 15 Apr 2026
 20:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260414105529.9883-1-popov.nkv@gmail.com>
 <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
 <CABQX2QMH2XFcuz00DQQWU4uKw2B8OzE4rCE5=8LMXDg4t0AqWQ@mail.gmail.com>
 <9a33c8b4-64f1-400f-b8a0-0972ea5b5ecf@amd.com>
In-Reply-To: <9a33c8b4-64f1-400f-b8a0-0972ea5b5ecf@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 15 Apr 2026 23:37:41 -0400
X-Gm-Features: AQROBzBeTXAsyPXmmTJlvmAfqcZclh41H9HUgy916nOi9mKbcOMPsijik6exNAU
Message-ID: <CABQX2QPatyzmoTJYv3C52aUfE2qS4bEr-01J5XbQnay94vs1Cg@mail.gmail.com>
Subject: Re: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in
 vmw_validation_bo_fence()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: popov.nkv@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org, 
 stable@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000df23f8064f8b8e20"
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

--000000000000df23f8064f8b8e20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 3:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/15/26 03:08, Zack Rusin wrote:
> > On Tue, Apr 14, 2026 at 9:25=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 4/14/26 12:55, popov.nkv@gmail.com wrote:
> >>> From: Vladimir Popov <popov.nkv@gmail.com>
> >>>
> >>> If vmw_execbuf_fence_commands() call fails in
> >>> vmw_kms_helper_validation_finish(), it sets *p_fence =3D NULL. If
> >>> ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_fini=
sh(),
> >>> passes the fence through a chain of functions to dma_fence_is_array()=
,
> >>> which causes a NULL pointer dereference in dma_fence_is_array():
> >>>
> >>> vmw_kms_helper_validation_finish() // pass NULL fence
> >>>   vmw_validation_done()
> >>>     vmw_validation_bo_fence()
> >>>       ttm_eu_fence_buffer_objects() // pass NULL fence
> >>>         dma_resv_add_fence()
> >>>           dma_fence_is_container()
> >>>             dma_fence_is_array() // NULL deref
> >>
> >> Well good catch, but that is clearly not the right fix.
> >>
> >> I'm not an expert for the vmwgfx code but in case of an error vmw_vali=
dation_revert() should be called an not vmw_kms_helper_validation_finish().
> >
> > To me the patch looks correct. This path is explicitly for submission
> > failure and does BO backoff plus vmw_validation_res_unreserve(ctx,
> > true). The backoff=3Dtrue branch skips committing dirty-state /
> > backup-MOB changes, which is only correct if commands were not
> > committed. Here the commands have already been submitted; only fence
> > creation failed. So I think unlocking BO reservations without
> > attaching a fence, then letting vmw_validation_done() keep taking the
> > success path for resources is correct.
>
> Ah! I would just avoid adding more TTM exec code dependencies.
>
> We also have the always signaled stub fence for such use cases. How about=
 that change here:
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index e1f18020170a..8dcb8cd19e29 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -3843,7 +3843,7 @@ int vmw_execbuf_fence_commands(struct drm_file *fil=
e_priv,
>         if (unlikely(ret !=3D 0 && !synced)) {
>                 (void) vmw_fallback_wait(dev_priv, false, false, sequence=
,
>                                          false, VMW_FENCE_WAIT_TIMEOUT);
> -               *p_fence =3D NULL;
> +               *p_fence =3D dma_fence_get_stub();
>         }
>
>         return ret;

Yeah, that would be an ideal cleanup, but it needs a lot more work.
The p_fence is a vmw_fence_obj so we'll need to write code that allows
creation of vmw_fence_obj with a signaled dma_fence and then plumb
that through the driver. We'll also have to change a bunch of places
(especially in older kms code) in vmwgfx that treat null fence as "the
device has already synchronized". It's the right path, but to fix this
particular issue I'd be happy to take Vladimir patch for now and
perhaps I'd ask Ian to put a proper cleanup on his todo.

z

--000000000000df23f8064f8b8e20
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINFB
rIE9ROoOc0xiUpWtzO6U/Fm02Q/KSp34pKYx00X/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNjAzMzc1NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG+q0rz1Q4UB2syWSijmwSYPN1TFf5AKljUY44y+
yBlvtwKWYHziOB/5kpoPEYd8VuKyGLjeUv48kB5j6nsP+btZP9uZPCV8rxVjghAuzL1jeh1QPgdr
hQPkfkv9VtA+EK+/K5QwGmuxwgtjGdisE+4Cfaxb0BbjHs9xf5BrHSP4F4ussmYXuWSXLqA1MJq/
6MYPySQAaU+TN3wfl1ffjEfB7DH7+nArNYmCOKkqnMaHJAjv/iUnyvX4KJUJYLyy6szGdYYfhT7J
a+sfKABJY8PyrwV+3jNOdqx9MRtd65hC88xFfWMRoeokekJBaFQhGXC//EkAmcF35KBGjkNtNO8=
--000000000000df23f8064f8b8e20--
