Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD67FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7ADA10E8FC;
	Mon, 27 Apr 2026 20:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="IpX+gMf4";
	dkim-atps=neutral
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com
 [209.85.210.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D9510E8FC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 20:08:56 +0000 (UTC)
Received: by mail-ot1-f99.google.com with SMTP id
 46e09a7af769-7d1872504cbso9001061a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320535; x=1777925335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2jP4QWXThIT/fdAWs6cCDWb99I49DlTyAeqp4TfTzQ=;
 b=CP9c0DXUnPzpRmEkN3uTeyhte+1WoAZfC8c0pferUiXxNG2HTyBbPpxZGB01nN27d4
 MjH9SoBf4d5c+56Ju7DDlPQUprpN9Y2XzzM2+PlPoEzAq34BZplEgp7VNve6k9W7lFPs
 L07eCwFvwcFjjjNRwGVuGAGBsW6mAluJu2ZpyLqA9JVz8trihhbGsf1P8zACjLX9Ei+b
 BNu3fNVrMKbtWBQFNZUmKWCg3rFTLGcKSFdHWeQNfFBcY53zVagVRX+Ly3HE29Mp7lrD
 gGwdx49TjK9wzQl7hB+cjyZB5pW7sdkei8TY4ODzdENUWP21hjcPvTW1UVtqhsQdG4Ez
 gyzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RiN3D2rLsmk5fytCrtjC/1JRzukRw+RpY2aoiJz33bNf0uXdQZToKGxbe4FoZ9w7goq4JwZq5C1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7YdWcr7rulu/Aat1CEnFjCkUQBRZiVYvcfmtio5G0mUNmou/J
 cVF0BL2TBBw8rWqf/zlFAgE6MLJfXJ63AJ1wNi/CHf+3Jbelo9TjfEUEmt4WDqzBYu9pYrimOt4
 171y3o9bv/58Zf2PFdApgps7IDfOq3q4pOuVM8pZ2cNF5MiXlzbQeq34bJOI+kmklSyw1K2H95X
 ur/QnGsrA2u7c2MP92bUG8iPRNbFpIxjROFOaFAms/WMm/rMAE1pZr92P7dL6fg43CKt6YtIWIR
 mPGuOgzAazilbuttrcS
X-Gm-Gg: AeBDiev5RRMBKfkQYLkjNWRZNrelXGFuNJe2FqnjL4lI7+UDTJg44HobQHLQ04DrHXC
 CugRTL4L1kvgBybU23ajWfdwbrR4TYRiwv9I+kD6IzM5DXzHQo0LDgBOJOdRWCwb8GmtJoFrqWx
 Z7Dm43KE9O6A/jcz5zTYpYe1Nw1dnEUH2+nYUZ5zcLdEfi0Dpi3d4zvjTrObkKIgaLLtBMQu9Tp
 51qCw4hxWKP89BJkhakWiUOb8Poe0Sdth2m+Q2iTzCpquuT+duot/fwXGvrNiBujICMCN+6PFME
 gCmBrxeqx1G14xWagp366FMrOR2MR9sD64s46/hqf8D3jy3zRVxaHRCDRlI63XOJc6qx2+39+LF
 /Y5ml6dv6qw4Y4HSZelygmvGhIZVR9Pugcyy/Ig1TowFbK/717TkMYelELi0d+wXwkbuNBdBv5M
 zT+9gq9Te3uG8NhHp6xRjTtgOaDhboSVTz3oMn0sqGN3SppJOLwKyn5oGMgkz/qQ==
X-Received: by 2002:a05:6820:198e:b0:694:7051:6fef with SMTP id
 006d021491bc7-6965c5ee2b5mr74021eaf.4.1777320534798; 
 Mon, 27 Apr 2026 13:08:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6965ba74a85sm19350eaf.25.2026.04.27.13.08.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:08:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d1dea12aaso986043f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777320532; x=1777925332;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O2jP4QWXThIT/fdAWs6cCDWb99I49DlTyAeqp4TfTzQ=;
 b=IpX+gMf44SayRUOftxhHwwOGx67N1MDhjWqrsHkLXJpmpy6MEd4cSKKBJxk4OQ3XDz
 aJpDQrRxb+XHc9AZbodqIJXoWb27kXEGP8YDQKiG73usK/jpkwqAV4sTk8T6nDwOR72d
 4SczgAHiCqTnZ3blFCRkkH16oiTHpOpsxYQXI=
X-Forwarded-Encrypted: i=1;
 AFNElJ/tk2dy0HC3GjZSTkZ6BSwhnTTMOGs4CNnwgwXO9rEPrkVLaqxliFEXk4eKy3UKbRoi24gmnSA6rU4=@lists.freedesktop.org
X-Received: by 2002:a05:6000:144d:b0:43e:a6f3:b763 with SMTP id
 ffacd0b85a97d-4464aced1cdmr420057f8f.44.1777320532190; 
 Mon, 27 Apr 2026 13:08:52 -0700 (PDT)
X-Received: by 2002:a05:6000:144d:b0:43e:a6f3:b763 with SMTP id
 ffacd0b85a97d-4464aced1cdmr420012f8f.44.1777320531556; Mon, 27 Apr 2026
 13:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260424092012.5694-1-christian.koenig@amd.com>
 <CAO6MGth7OXG64pBxdtHU67M+yQ7QM7rSFQTmT57_1sC6TQMK4w@mail.gmail.com>
 <1b5f0648-6532-4b59-a1d4-21c470d17464@amd.com>
In-Reply-To: <1b5f0648-6532-4b59-a1d4-21c470d17464@amd.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Mon, 27 Apr 2026 15:08:39 -0500
X-Gm-Features: AVHnY4LEYdAuChm9eMmwSxFOMbLaaY7wdPgtH5Q_QUaIuGCRKDWTi7m0vJagPrg
Message-ID: <CAO6MGthCeOuXr4MJQYXsnzGRAJhJ=3_-0ARypPuxngxUa0=GCg@mail.gmail.com>
Subject: Re: Finishing drm_exec cleanup
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000feeb05065076ae7a"
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

--000000000000feeb05065076ae7a
Content-Type: multipart/alternative; boundary="000000000000ef9086065076ae7a"

--000000000000ef9086065076ae7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The problem is that we create and reserve a new BO in vmw_cotable_resize as
part of the validation phase but this BO is not added to the drm_exec
context so it never gets unreserved. This only worked previously because we
operated on the vmw_validation_context::bo_list. This can be hacked around
by using vmw_bo_fence_single in vmw_cotable_resize but the correct solution
is to remove vmw_validation_context::bo_list and only iterate over the
drm_exec list. This then requires plumbing the drm_exec object through all
bind and create resource function hooks.

On Mon, Apr 27, 2026 at 6:29=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 4/24/26 14:55, Ian Forbes wrote:
> > When I tested this last time the first patch was fine but applying
> subsequent patches broke vmwgfx. I did get it to work but it required som=
e
> hacks and at the time there was a major conflict with the ttm -> gem
> reference counting series. I will try again now that the reference counti=
ng
> changes are done but some changes will be needed in vmw_cotable_resize.
>
> Yes since the ttm -> gem reference counting change is already completed i=
t
> is now the patch set becomes a trivial replacing the old function with th=
e
> new one.
>
> Of hand I don't see any dependency with vmw_cotable_resize() any more, bu=
t
> it clearly needs some testing.
>
> Thanks,
> Christian.
>
> >
> > On Fri, Apr 24, 2026 at 4:20=E2=80=AFAM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com <mailto:ckoenig.leichtzumerken@gmail.com=
>>
> wrote:
> >
> >     Hi Zack,
> >
> >     VMWGFX is the only DRM driver who is still using the old ttm_execbu=
f
> >     framework and while going over my TODO branches I've found that I
> never
> >     upstreamed the patches to clean that up and fully move over to
> drm_exec.
> >
> >     It should be a trivial 1 to 1 replacement now, but I can only compi=
le
> >     test it.
> >
> >     There can be more cleanup on top of this, for example as far as I c=
an
> >     see vmw_resource_check_buffer() actually doesn't need a ticket. But
> this
> >     isn't the topic of this patch set.
> >
> >     Please let me know what you think since that would allow remove
> quite a
> >     bunch of otherwise unmaintained code.
> >
> >     Thanks,
> >     Christian.
> >
>
>

--000000000000ef9086065076ae7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,sa=
ns-serif">The problem is that we create and reserve a new BO in vmw_cotable=
_resize as part of the validation phase but this BO is not added to the drm=
_exec context so it never gets unreserved. This only worked previously beca=
use we operated on the vmw_validation_context::bo_list. This can be hacked =
around by using vmw_bo_fence_single in vmw_cotable_resize but the correct s=
olution is to remove vmw_validation_context::bo_list and only iterate over =
the drm_exec list. This then requires plumbing the drm_exec object through =
all bind and create resource function hooks.</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Apr 27, 2026 at 6:29=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"ma=
ilto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/24/26 14:55, Ia=
n Forbes wrote:<br>
&gt; When I tested this last time the first patch was fine but applying sub=
sequent patches broke vmwgfx. I did get it to work but it required some hac=
ks and at the time there was a major conflict with the ttm -&gt; gem refere=
nce counting series. I will try again now that the reference counting chang=
es are done but some changes will be needed in vmw_cotable_resize.<br>
<br>
Yes since the ttm -&gt; gem reference counting change is already completed =
it is now the patch set becomes a trivial replacing the old function with t=
he new one.<br>
<br>
Of hand I don&#39;t see any dependency with vmw_cotable_resize() any more, =
but it clearly needs some testing.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
&gt; <br>
&gt; On Fri, Apr 24, 2026 at 4:20=E2=80=AFAM Christian K=C3=B6nig &lt;<a hr=
ef=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.le=
ichtzumerken@gmail.com</a> &lt;mailto:<a href=3D"mailto:ckoenig.leichtzumer=
ken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;&g=
t; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Zack,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0VMWGFX is the only DRM driver who is still using th=
e old ttm_execbuf<br>
&gt;=C2=A0 =C2=A0 =C2=A0framework and while going over my TODO branches I&#=
39;ve found that I never<br>
&gt;=C2=A0 =C2=A0 =C2=A0upstreamed the patches to clean that up and fully m=
ove over to drm_exec.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It should be a trivial 1 to 1 replacement now, but =
I can only compile<br>
&gt;=C2=A0 =C2=A0 =C2=A0test it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There can be more cleanup on top of this, for examp=
le as far as I can<br>
&gt;=C2=A0 =C2=A0 =C2=A0see vmw_resource_check_buffer() actually doesn&#39;=
t need a ticket. But this<br>
&gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t the topic of this patch set.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please let me know what you think since that would =
allow remove quite a<br>
&gt;=C2=A0 =C2=A0 =C2=A0bunch of otherwise unmaintained code.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Christian.<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000ef9086065076ae7a--

--000000000000feeb05065076ae7a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIImH
SHHTZVh3oLQtqLrnlE7+jAGTA2wpOLP5oxVIKupYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQyNzIwMDg1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACYfGmA31jMUZGdIN83mF3TaGI6bN+GdIXLUFAHB
6HhhEEHANzCqPlJrj+pNicfqgBOp5IblHMRmrwy2q+dGBVusq9V5BEIb3dC/gSZYjM7kbOxXVMUR
7obUyXXjwpKK7NFwWAR7LzyDoGe7JKWqV2rJ3dDcjYqTOJcnl+zgvogPMqvOAy/iAtoEShsrL/s+
tGattCdl1na8l+9xMbjJebRptqKLcrpF/kVblAYBemdoRRpSKAEu8eMKzBpQ9EPeCKn1MlQdG5Pv
GjdO4ch7jb7zlwbEeoahiFEblxUsDkrVDXgOrvuTYtpeZgvuqJ1aiipYkK5vSxSXGV3lQv9/QGY=
--000000000000feeb05065076ae7a--
