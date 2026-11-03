Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA5606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeAnmVj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E7A10E7CA;
	Tue,  3 Nov 2026 08:21:53 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4FD10E75C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:33:17 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5eafb65e163so1899441e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793669596; cv=none;
 d=google.com; s=arc-20260327;
 b=JUrws+LzQVRxZMW06iinQYWEP/dhLp3t65naFJtzQLJIiNlEXxkmc1WWu92O6HD6F4
 7Lesga7XZrHjJLm78/Y53UfXNz4VxeiZcnfolImqwGhWVzr6rUeA+uGe6bfD2HnmV2x3
 6Qt/9xeJhCW/0SCilUzv8I9hmDpA9c1MqYMO8U2tKmzuDUzRNn7PwNLR28l/gQAt+l5a
 hYagU1cv/MVMvmGeAScaoJp5vJaAMTw+NUizZVPIOxCv4AxN/WbFcXtazotRbS2FVWVE
 h5cOh624O2D4IbIP/Q2eoD+xwaTSNyBhzSE++/zwybUreH6HNOsHwNn1AkuvxeYDo+mF
 25GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bUh2za17AgvKKcfLJiL9IJEEdmk7XqULVrgl1sCD7Ks=;
 fh=bS0PkjEvlpbe54Cx+bwESLy5u8B4bW8VLNr0qBFB8xQ=;
 b=noQ0Jlve5btQe3aMPM5eAN45rugGTI1YzdggBiPUukTtFf0Ss/7sJZh1scDpVx1Hv6
 N74ypSnffDk/+gm0iyqF0JytGCl/NDCdBcoXQyslQybMjoNJ8zX/l6c1Kz5tkoZzhS4m
 DU41jgohUeIGZiUfkhq1zi4hOV0GkOmjufOJ9ygOQJezPckypizIW3chgVbSoVYftujF
 ECZY1prf5s75G2I+5sz5hkHpZ0WjRvGFtkhTKTiy5NoMwHl1CJTcgXPNePa7AYotE5W3
 wvvfKZga1bXakmJrIWS+IOF3WL+EWjpMXfzS5ANFWYBK7N1E41E9vFvIc3uUHJyT8OOm
 JjNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793669596; x=1794274396; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bUh2za17AgvKKcfLJiL9IJEEdmk7XqULVrgl1sCD7Ks=;
 b=XeAnmVj9Um8BsfQr0OZ7SBkRfR5uWKG7sAkt3RKnVPszJlg4FQ+iAGxAKMVv8eTKyn
 wv62nC+VPSFdBw7vHtJWXT/bBRFWCTMZ2inkTEyiu2NC53SEfru70YEdhVz+k0wOasWo
 9Q8UJoqxb8JnHly2fCi/qurRs9Yf6IakEnVLOUQFypLC5Aqc/adWPUV6EfHb5KjU3Z9a
 8LznXg85s+eM0e9zMxB2cJqh/Gcy1X6BUwD/woOg/LnNhk/pyrO2xfUIIBmji0YcdKjV
 Zv9SSBUrtXxNVOgeQTo9kmASimA5E0iSd5Pnhb9tN2pY0s0+m8cfjeVfh/OxSZTFhQ0b
 VS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793669596; x=1794274396;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bUh2za17AgvKKcfLJiL9IJEEdmk7XqULVrgl1sCD7Ks=;
 b=OYAFM0GQ0w8I48cWM+ywjrg9evzbZpeRfs/qOzb2yoi5XpPgjv6rCnf7ibNl4Oryf8
 Q3ju9KGoFc3tJuzBTFe8AxmxjZM9qPrKIWWqka4DPs2wFfrHWxF3IbOUOMh6I7Z0PuqA
 9oVUUvR33ORu2txcszUD5AbPv+GI4PwRaK+OuVQif3L4ekZxqtRR+sdf8K+VIbzxIEsL
 qv9Ari8r7ynRbpuJDD4q2LGxSIs1Sdjv0hWuOMI+zZ8veFvFJwyg3A80w0g/tEb00P7J
 l9Tc+/BUVL1CEE+JKIWeNgi9U2wsSyR7MY41frsypFTMgfsXG1k5MUpNQ7Uhm1TShK/u
 rz8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7Q7l47TMdjQ1SqDbs/vGoap3/Uh+bWj2GUVAMBnYKO7bgw+v601da4qNITi/w4K3BtomnPiLL7CU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8fB0R6E7GBVc4WX9OzZbJ/9iST46G1UIvJMKgEH+i7czyHWOqy
 0izEGQUIUEmpVOMF/ur3uAiwy2XJDt/A3g5/csWY1pbx6o95wo7p/VQqkLvw4X6YD/NzzmPGJ0x
 /uWohh+Cg/8EkwTtKmi3vFd4KKgVYsQE=
X-Gm-Gg: AYBFou3lbOuFENBl8zF4oA/UJCYoZSUaY58aAN6qSfYh+Hg6ozS5sukj2xc0GnKeA6c
 fZNsa83e13roE1SU3ByHSAD7I2rwK0pjUJcQKSYWjWu0oj7HjEpW6P3ChSdoAXjN3AuTDa5jD/r
 dVOjFbiCgms9vJILx8y0oUAQwIxLzA61Gk+fdtgNTMOTgqu4fh7pvjp8P9IOOH21KE3TCZmXueV
 WdGH61oIbRcqXsVuFUBfWAVrTEmLqMRC+4P6pSnP6DMAnu7V2rbh3NumtRPRoNXs5j1P+EDWJX9
 gC4MAq+L5ReQqFtDm+dSmYF8B/wOq0hBm4hOHfeZBtvqzsME4q4CkNa1YDPCBjufYnW/hvihS1h
 WguYqQG8b4jvElXHtUp8J0QeFHX2tIcJxYMADZXBHzRsghhyr1KGnpPSHdQWa3R+UUBw=
X-Received: by 2002:a05:6122:e18c:b0:5de:ee96:75b with SMTP id
 71dfb90a1353d-5ec6898ec3bmr5018367e0c.12.1793669596223; Mon, 02 Nov 2026
 17:33:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Balakondareddy.M" <mbalakondareddy@gmail.com>
Date: Mon, 2 Nov 2026 17:33:04 -0800
X-Gm-Features: AclHuK-penGumdnzeaaET1cJkDpnx6KYbBw4mnN3iNjw4LNJZ55x77kTaNfuf5Y
Message-ID: <CAGETjgzeVyLHXWwGgpN4eRms8o6gRnO8hVmdd6RzYRagVS2==A@mail.gmail.com>
Subject: virtio-gpu: question about device-aware logging conversion
To: airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com
Cc: sean@poorly.run, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev
Content-Type: multipart/alternative; boundary="000000000000209e55065f553f5d"
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:46 +0000
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000209e55065f553f5d
Content-Type: text/plain; charset="UTF-8"

Hello Everyone,
My name is Bala Konda Reddy Mekala. I would like to contribute to the Linux
kernel.

While reading the DRM TODO list, I found the " Convert logging to drm_*
functions with drm_device parameter" item and chose it because it is marked
as a starter.
https://www.kernel.org/doc/html/latest/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

The TODO recommends contacting the relevant maintainers before starting the
conversion process. So, I am checking whether you would welcome patches
converting the legacy DRM_ERROR/DRM_INFO calls throughout virtio-gpu to
device-aware drm_err/drm_info calls.

I made a small local change in the drivers/gpu/drm/virtio/virtgpu_prime.c
file by replacing DRM_ERROR() calls with drm_err() call. The message
strings, failure conditions, and return values remain unchanged. I compiled
virtgpu_prime.o before and after the change with W=1, with no warnings
observed.

If the conversion is welcome, which tree and branch should I base the patch
on? I plan to submit this as a single patch, since it is a logging cleanup
across a few files in virtio-gpu.

For reference, the initial two call diff below of two changes

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c
b/drivers/gpu/drm/virtio/virtgpu_prime.c
index ebf471044d06..8d764e4001f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -289,13 +289,13 @@ int virtgpu_dma_buf_obj_resubmit(struct
virtio_gpu_device *vgdev,
        int i;

        if (!bo->sgt) {
-               DRM_ERROR("no sgt bound to virtio_gpu_object\n");
+               drm_err(vgdev->ddev, "no sgt bound to virtio_gpu_object\n");
                return -ENOMEM;
        }

        ents = kvmalloc_objs(struct virtio_gpu_mem_entry, bo->sgt->nents);
        if (!ents) {
-               DRM_ERROR("failed to allocate ent list\n");
+               drm_err(vgdev->ddev, "failed to allocate ent list\n");
                return -ENOMEM;
        }


Thanks,
Bala

--000000000000209e55065f553f5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Everyone,<br>My name is Bala Konda Reddy Mekala. I w=
ould like to contribute to the Linux kernel. <br><br>While reading the DRM =
TODO list, I found the &quot;

Convert logging to drm_* functions with drm_device parameter&quot;=C2=A0ite=
m and chose it because it is marked as a starter.<br><a href=3D"https://www=
.kernel.org/doc/html/latest/gpu/todo.html#convert-logging-to-drm-functions-=
with-drm-device-parameter">https://www.kernel.org/doc/html/latest/gpu/todo.=
html#convert-logging-to-drm-functions-with-drm-device-parameter</a><br><br>=
The TODO recommends contacting the relevant maintainers before starting the=
 conversion process. So, I am checking whether you would welcome patches co=
nverting the legacy DRM_ERROR/DRM_INFO calls throughout virtio-gpu to devic=
e-aware drm_err/drm_info calls.<br><br>I made a=C2=A0small local change in =
the drivers/gpu/drm/virtio/virtgpu_prime.c file by replacing DRM_ERROR() ca=
lls with drm_err() call. The message strings, failure conditions, and retur=
n values remain unchanged. I compiled virtgpu_prime.o before and after the =
change with W=3D1, with no warnings observed.<br><br>If the conversion is w=
elcome, which tree and branch should I base the patch on? I plan to submit =
this as a single patch, since it is a logging cleanup across a few files in=
 virtio-gpu.=C2=A0<br><br>For reference, the initial two call diff below of=
 two changes=C2=A0<br><br>diff --git a/drivers/gpu/drm/virtio/virtgpu_prime=
.c b/drivers/gpu/drm/virtio/virtgpu_prime.c<br>index ebf471044d06..8d764e40=
01f6 100644<br>--- a/drivers/gpu/drm/virtio/virtgpu_prime.c<br>+++ b/driver=
s/gpu/drm/virtio/virtgpu_prime.c<br>@@ -289,13 +289,13 @@ int virtgpu_dma_b=
uf_obj_resubmit(struct virtio_gpu_device *vgdev,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int i;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bo-&gt;sgt) {<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;no sgt=
 bound to virtio_gpu_object\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 drm_err(vgdev-&gt;ddev, &quot;no sgt bound to virtio_gpu_=
object\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return -ENOMEM;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ents =3D kvmalloc_objs(struct virtio_gpu_mem_entry, bo-&g=
t;sgt-&gt;nents);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ents) {<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;failed to allocat=
e ent list\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
drm_err(vgdev-&gt;ddev, &quot;failed to allocate ent list\n&quot;);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br><br>Thanks,<br>Bala</div>

--000000000000209e55065f553f5d--
