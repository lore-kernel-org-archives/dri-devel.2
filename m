Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6B606A327
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=b8kSJx6V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CD010E170;
	Tue, 10 Nov 2026 18:50:10 +0000 (UTC)
Received: from mail-pj1-f102.google.com (mail-pj1-f102.google.com
 [209.85.216.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7138410E170
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:50:04 +0000 (UTC)
Received: by mail-pj1-f102.google.com with SMTP id
 98e67ed59e1d1-3b0d09df973so1856136a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794336604; x=1794941404;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=38IHwhn1DICsyWCNhasUcdlx3lwDyhvIm8GoECKPPQ0=;
 b=PxDYwYBw4y2/+Mh3cHAXl+tEi8FO/jIjqQ2dooUmzkJs1+O2dJbMl27msMxlPucKoy
 gEJd/qcptO/Jl6IKwZdnOk2BO2DSvghmioRKboIQq9m7fZpxmhfqtdp3+GvxLbX5vIlh
 RjNL73rdMoxdLEaigPgvGQ/OkfjJwnyAvp1nCQ/SkOI0bd1LkSn9dYYA0DFKIoEvIR/3
 kc3P/YDYPGfpyYtxuXr6PpHtrW8YbQ6HOG7PUSFsPtiblKFVPUCYDpkgvzBn8gJXu9v/
 f3gboWmAtCj/XVKOMiLHhm9nU0rogFPtcfYUdYyZSVQEyDBiz3+lvDJvxVFs4SVX0EL2
 ZIgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGavTfua1YxAYOeevERHlup/wfgfC/HPK4SHOeVXqzPu1uT35nVeoG26JcTXWFS8Pe44hQYhxPA2Zs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83KHJwOitIifT0yHiRLFPa0iTB30dMkzNGVbXPVXRKQlLPHUZQ
 dbVpe/gds8kgZ924hVVuDLWK3J8AKJBiSg9AQN/c/MGahSUCzsT1OVHJye5JJEQ8My5POl7m/3d
 0xKkv5WOJMSREeluTPxKysHG9UmyxUd7LQpp55eiXHYI2KJxfbBkOtce4Ev4/Cihor9d1l8ehJ0
 7W7tlYzD+YE3zFMbIX1uVNvGZ20BRx0cJRR+93+/UbEOf1PsOjTWmn+ljGQsJO0oNholP1VbIEM
 PkV+/U1N8xFzPBQ3wGte7Y=
X-Gm-Gg: AYBFou1fN4eUpk7GMk3ja4SRS84Ct+4xgV0qKPtx9RvT3G2Oh7n+tz7hqUK8RWnpHqa
 y91vw+XAQAi1LlSFHjUtec+3FzBFuciZbNxMeOBTol2F0Tvs5QNbdeUguVcBwERpIvp1uWUUr44
 UDR/2xsunnLwWYfhL/8Y/L6KKkvkBGOk9WLMkuRouBC7lqULmYLuf2ehIFN7kUNQ7eUKSS7dzcm
 UdcxF8Cy20gdWqYSJDRIFlofXoLA8sdphDKJkAGgOA2oYTyDryHpB/JtTfABb8Nr2gtE8o3iFI+
 MTHJ7fZbrvjd2678kiqALU5tHTz3WjNTrur4tq6DjEWNWCAwKpaOQ32mvklJACVE2vyWBP4ofiH
 vxc6Ba0Fg+7cd35QsS1Zc8T7xdkuNP5epKFH9NbkdCDPYTG7vGZCidDFK4+4Wv0L9tPOATNB+Jl
 v5WMm8KQsRPtJYVKxS+I0mJ3HTqX4ZvoBD
X-Received: by 2002:a17:90b:384f:b0:3b0:cc6f:104d with SMTP id
 98e67ed59e1d1-3b166fc0d67mr3849042a91.51.1794336603659; 
 Tue, 10 Nov 2026 10:50:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b17db7fc21sm385841a91.7.2026.11.10.10.50.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Nov 2026 10:50:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so5134287eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794336601; x=1794941401;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=38IHwhn1DICsyWCNhasUcdlx3lwDyhvIm8GoECKPPQ0=;
 b=b8kSJx6Vp+DkZVwQTkTNA+z4BdneVVV/f6uQd9TbZSFL38Rps0Ewydr87AfRehBWgL
 rYdExJ7YjboPX4iIjJ2KOUo/PkKiztYy4WZYZ3VIbgP3A//EuSmwL5hDiNugjcYZ+CZc
 RMnfw0kIFuAHmpBaBsia26fsC2qYOcXCDzvKc=
X-Forwarded-Encrypted: i=1;
 AL+hErFKFfGJdmfUrE6QrZdI5p9Wc4rflkoazV2sb2MpQNUDaOGCsd8MevjNlfVJ2WWmm9ATiAZ2jCBSKpE=@lists.freedesktop.org
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id
 5a478bee46e88-376861801e9mr261495eec.20.1794336598071; 
 Tue, 10 Nov 2026 10:49:58 -0800 (PST)
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id
 5a478bee46e88-376861801e9mr261404eec.20.1794336596867; Tue, 10 Nov 2026
 10:49:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110084710.503870-1-tzimmermann@suse.de>
In-Reply-To: <20261110084710.503870-1-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 10 Nov 2026 13:49:42 -0500
X-Gm-Features: AclHuK8-P0Cj-xUNZlNamFcxKz9crXduQgmI-OdXcagOmvIZ8CcpGbw7lqHvys0
Message-ID: <CABQX2QPwdFeeCHXKiFm0DDAo+URu4sXy1qGdxw5Wwit1hdX_OA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/vblank: timer: Fix race condition in
 enable_vblank
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ville.syrjala@linux.intel.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com, 
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000c0fa8a065ff08b12"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c0fa8a065ff08b12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:47=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Busy-waiting in drm_crtc_vblank_start_timer() until a previous vblank
> timer has completed can deadlock. Rework how the vblank timer's start
> and cancel helpers interact with the timer function.
>
> Patch 1 fixes the possible deadlock by removing the busy-wait loop from
> drm_crtc_vblank_start_timer(). To avoid possible interference between
> _start_timer()'s hrtimer_start() and hrtimer_forward_now() in the timer
> function, extend the interval_lock around both. Both, _start_timer() and
> the timer function, can still overlap, but hrtimer initialization should
> work reliably. At most, the first vblank event after changing the interva=
l
> might be off.
>
> Fix the possible overlap by canceling the vblank timer's internal hrtimer=
.
> Do this outside of the vblank code's critical section after switching
> the vblank timer off. With the hrtimer being canceled, the next vblank
> event will be sent at the correct time.
>
> Tested with bochs on qemu.
>
> Additional notes: there have been reports about vblank timers not happeni=
ng
> in time, such as [1]. We suspected that might happen due to guest systems
> running under high CPU load. But the problem could also be caused by the
> deadlock fixed in patch 1.
>
> v2:
> - handle uninitialized timer in drm_crtc_vblank_cancel_timer()
>
> [1] https://lore.kernel.org/dri-devel/6a176ae6.d07c18fe.1069e4.0016.GAE@g=
oogle.com/
>
> Thomas Zimmermann (2):
>   drm/vblank: timer: Do not block within critical section
>   drm/vblank: Cancel vblank timer outside of critical section
>
>  drivers/gpu/drm/drm_vblank.c         | 90 ++++++++++++++++++----------
>  drivers/gpu/drm/drm_vblank_helper.c  | 16 +++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  3 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  2 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  2 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c |  2 +-
>  include/drm/drm_crtc.h               |  9 +++
>  include/drm/drm_vblank.h             | 16 +++++
>  include/drm/drm_vblank_helper.h      |  2 +
>  9 files changed, 108 insertions(+), 34 deletions(-)
>
>
> base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d
> --
> 2.56.0
>

Thanks for doing this. Looks great.

For the series:
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--000000000000c0fa8a065ff08b12
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICgv
ZBt9WZJVNoCzgxosl65W33PyV/4ppwnoRykG9x4gMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExMDE4NTAwMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHzNbrCSQaSHtmEh4uzC5spY1kmS/RDbuIHrZ5I8
qJZiQu7wPzW6KSwaH4lm6Ngpx8GeZ9z5PeDzYPaCnf74wEBPIooa+WFkGE1tzV4pXbrjGyWHJ8V5
qIvOjgxkB+Gb3vQYWJbuR3eWEyH3hEAa0x/LgJ2IAdTOcagPDUIhKrsjsmuqXI2xmdd2L5QkLtWq
3uZ2yXl8sl5TsV4/Mlgia4N/ubnyxUe5qFGB093e6W7VjuJpYQEjQcvc0Kdmluh1+8OhfR+yjdpP
5RfTs40mOcnL27K59zwpMFzlmUiq0PYbGWLlyYLG30uUYzt4rHHdAKq96TvPURWZQHpPnUmjLhU=
--000000000000c0fa8a065ff08b12--
