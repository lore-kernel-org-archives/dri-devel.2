Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E97606A339
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMI+KwuR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C36112C72;
	Fri,  6 Nov 2026 09:19:06 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C1B10FF62
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:19:04 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso51555b6e.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 14:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830744; cv=none;
 d=google.com; s=arc-20260327;
 b=Sn95TQgMbC8Pq2aS3w2FkxAHEo8DQFltCotqrxYZ028bzQOIcv8/Cr1PCIXPTN4Sfw
 EvxxV7WbGxiC5lEwKjVpQGCcsDz5X2smFzL+RJ8jcVduTui+tSuBlGjOa9x1VRnPZgHk
 B5j+f+dzQa3T+NSYk5n47OLgt9ow/pyTox+KPoYFvBplF+ukaH2GzrDI2RaqQUhwMC6W
 LaS6eNrjwwX7idW8mon/zYPv7F9eF6AJBPuscEH2eaMQ2rEAGoRYoioKCV4YATjhq18q
 HHs9kWzKC2zC4nqW5o06rCLxA2xSVNo/o3E5nTFhpLUub9oCKuJcRlaX0jqgi2ilocB8
 f0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3UtA67yIEes4aqpwRVsBn0qyhO4Y0qMkibk7Y7L12TU=;
 fh=B0p+gFy9C+0HEWOwhNiauj9LLZqQbmGd5k85H0yCt8o=;
 b=lFp5Uf7I0qP2h21jL43kqjbhNBN3HIPARFD8o70mJMbMv0aGsOcyXpdqh0cfPGPw6Q
 CG2J+q3UZOIbwcaNn5k+4sFnc7XtYKEy5UmisIZRS/2U2yVmjN13291oi0dnnn4eRVou
 kY6bJW7aaYtqRUkbnPnd8QAmvbN62UYcBOvWXnRbZ0q+sOge7TcZz6/waTGzGUDFEkso
 vKzNkDQ7S56IxZwMVKBWXRqCzn3A5IVGhS2STXceru0k/dzJQSE5PlZJRyQNIqqz+goQ
 OY7W4QY8Vc+9u+qjMyX7IhD52TQapsUUFt3I1dkea1/Xe4iJPhGwqPE3IOdoZrpgYhtZ
 1gUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793830744; x=1794435544; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3UtA67yIEes4aqpwRVsBn0qyhO4Y0qMkibk7Y7L12TU=;
 b=dMI+KwuR5jEXSBlvMMgnqIWyErBOTPqSBUdbkRNneul92WQzy6GAhwKwwKa53xuDrP
 AdFBP7pAuffgyfmkB7NLTwoQ0oD7L/vumiyk2nEUfAjT+IO4fNIfzuD4ngMgBMN29pY/
 x2jFqitigH+AlegTD9NeV/1zeAHne/WtMmBEldHQHUb6OcfR2Iko6tJqzXun4E0Ywh6j
 QTPfkBaSEuEP+9R2RTC/+fZsROc37j4sXvZzguFAEVda/eDJbMiNcluqtVI64JV4+QiR
 asnZGVK7XOcjQ9cT2aziIyZBa64Wz6TAu0z91tgc6Wa/08dIZ6KlDtshXyNnll5LHVT4
 vY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830744; x=1794435544;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3UtA67yIEes4aqpwRVsBn0qyhO4Y0qMkibk7Y7L12TU=;
 b=OVtn9GOv7iAlhquJVmKdeO+iK3ffQWES4mMRPdUyt+YenZWuZvxBL6ewP+hRXC8wJY
 jx3LAxZA09/6GS57OGiVtAh1+3KbbJr9stH50YUt+OA7G4ORJHkVOLY5yIQE7VqksHd2
 T822q4iLRwnYJhtRiKHy2ZlE0jjsuE4FnUNGDXFPHLeqEQCsXAGRz3HCJ1+g18NEtaQB
 bhSzoKAsr69HoDvcN2D0LnBQ1PFaMXOuBASl+vuq6qxjCqvTJK8E7AJBJbfH9zE6PKPd
 ExzNjqgrFa2vkgtgOb6hb+lbkVdtHoOlVymUiVXPFRmNRUUc807nw87sQUjzYfFcaeEh
 TERQ==
X-Gm-Message-State: APuU4Z8A8FSldxjj7141Kn0TKaVg7FlfaT8C+k2FLdhXXK8Lrjfm+H8k
 WoocIEpzJ6iUqe2sQAdABMLkom7cC4ZvQpdNtnjfq4JtMbH1Jn+TugjA0MdiproS7ccXGIsF3XS
 dmCyv0nhixZP7K02Mp8lLxRIWcRz93o8=
X-Gm-Gg: AYBFou0TqxsCsGfru3pq5Bmrqek52iCa4xqY8/iw6VAKxcUvA8Ry16mbts0Rn2zh3Rh
 aG+u6Q2Hoj704bicYrVjcQ4uydn4gmfUSLPUTnfTE8Owh3ZQQq0AJil8AnOBxSSXIO/KsVsrH2P
 oAWvCyBkUcbVOiElWTTuWNxyFgTAA0lez+cWY6OgL5sCDVAKFdrcvR7NZb4uqS/OgS0CkCNQKYv
 I4x7jG2/QlSd+sVl7gVjsr+kOe7LzU531RMG1i1Y1cSb/6Y2ZZb4rglWZGu+P5QVyXHtq+itZ8g
 2npGXuPC67m/J3W4o1YyDxQQObMXs+TfeO8gBvGBebLqOAqvoKhEaUauVyrTfDV4fBey6Wb3IU+
 qMvQncakR4R9rCwkEa3uaDeUOzeuWWrI0ttjPEcVrfwF+kgRMFwmQu0h5GUXM7Yy0IuKBzAbYUk
 qWIlAwuDUn9N8RC9Kd1ZQmhwWxwg+C
X-Received: by 2002:a05:6808:1924:b0:4d6:9133:cfee with SMTP id
 5614622812f47-567be7bd56dmr536463b6e.51.1793830743559; Wed, 04 Nov 2026
 14:19:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Date: Thu, 5 Nov 2026 03:48:52 +0530
X-Gm-Features: AclHuK_Fakj5u13wNRf4BMTD2H9gLGNYx9xEu9Mi38OxBsJLkZ9qiJpS65NZd10
Message-ID: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
Subject: [PATCH] dma-buf/sw_sync: Avoid taking references to released fences
To: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, syzkaller-bugs@googlegroups.com, 
 syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Content-Type: multipart/alternative; boundary="00000000000041d1e6065f7ac4e8"
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000041d1e6065f7ac4e8
Content-Type: text/plain; charset="UTF-8"

The last dma_fence_put() can drop a sync point's reference count to
zero before timeline_fence_release() acquires the timeline lock to
remove it from pt_list. If sync_timeline_signal() acquires the lock in
that window, dma_fence_get() attempts to increment a zero reference
count and triggers a refcount warning.

Use dma_fence_get_rcu() to acquire the temporary signaling reference
only if the fence is still referenced, as sync_pt_create() already
does when looking up an existing point. Skip a point whose reference
count has reached zero: its release callback will remove it from the
list and tree once the timeline lock is released.

The timeline lock prevents the release callback from removing or
freeing a listed point during this check. For a live point, retain the
temporary reference until after dropping the lock, preserving the
protection against recursive locking from signaling callbacks.

Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence
signal")
Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---

 drivers/dma-buf/sw_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 8df20b0218a9..7f1eadee4cdf 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -221,7 +221,8 @@
                if (!timeline_fence_signaled(&pt->base))
                        break;

-               dma_fence_get(&pt->base);
+               if (!dma_fence_get_rcu(&pt->base))
+                       continue;

                list_move_tail(&pt->link, &signalled);
                rb_erase(&pt->node, &obj->pt_tree);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d

--00000000000041d1e6065f7ac4e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>The last dma_fence_put() can drop a sync point&#39;s reference count t=
o<br>
zero before timeline_fence_release() acquires the timeline lock to<br>
remove it from pt_list. If sync_timeline_signal() acquires the lock in<br>
that window, dma_fence_get() attempts to increment a zero reference<br>
count and triggers a refcount warning.<br>
<br>
Use dma_fence_get_rcu() to acquire the temporary signaling reference<br>
only if the fence is still referenced, as sync_pt_create() already<br>
does when looking up an existing point. Skip a point whose reference<br>
count has reached zero: its release callback will remove it from the<br>
list and tree once the timeline lock is released.<br>
<br>
The timeline lock prevents the release callback from removing or<br>
freeing a listed point during this check. For a live point, retain the<br>
temporary reference until after dropping the lock, preserving the<br>
protection against recursive locking from signaling callbacks.<br>
<br>
Fixes: e531fdb5cd5e (&quot;dma-buf/sw_sync: Avoid recursive lock during fen=
ce signal&quot;)<br>
Reported-by: <a href=3D"mailto:syzbot%2Bcba1a1f459230395a076@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+cba1a1f459230395a076@syzkaller.appspo=
tmail.com</a><br>
Closes: <a href=3D"https://syzkaller.appspot.com/bug?extid=3Dcba1a1f4592303=
95a076" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/=
bug?extid=3Dcba1a1f459230395a076</a><br>
Signed-off-by: Kirtikumar Anandrao Ramchandani &lt;<a href=3D"mailto:kirtia=
r15502@gmail.com" target=3D"_blank">kirtiar15502@gmail.com</a>&gt;<br>
---<br>
<br>
=C2=A0drivers/dma-buf/sw_sync.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c<br>
index 8df20b0218a9..7f1eadee4cdf 100644<br>
--- a/drivers/dma-buf/sw_sync.c<br>
+++ b/drivers/dma-buf/sw_sync.c<br>
@@ -221,7 +221,8 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timeline_fence=
_signaled(&amp;pt-&gt;base))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_get(&amp;=
pt-&gt;base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dma_fence_get_=
rcu(&amp;pt-&gt;base))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_move_tail(&amp=
;pt-&gt;link, &amp;signalled);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rb_erase(&amp;pt-&g=
t;node, &amp;obj-&gt;pt_tree);<br>
<br>
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d<br>
</div>

--00000000000041d1e6065f7ac4e8--
