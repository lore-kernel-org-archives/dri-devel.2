Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648B606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xh8sqDSu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FF510F331;
	Tue, 24 Nov 2026 08:43:33 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6877010E0AB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:47:07 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-9213fddb596so50859696d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795492026; cv=none;
 d=google.com; s=arc-20260327;
 b=p3swtVq3hheS6PsDWCVLj5oh5U9N/yguwquSk34688j4eMyeXdRcfNw1WJ8LGekMPE
 Q7JA+RsEFFoJ7hoR4hON8scYWFqnVhc6mg/uxs6o0BC3YacTzGxIrL7SN6tmKu6j4N/p
 A4u2+lssNH/wWuZ5nmju9+eFwth5rre/mrOmLWVb9ztNolwRsrTI6VlVuIX8B8yZdnmd
 vZJcFgUL8oCMFZ8cLRZhIm20rh1bx6Ebbmd6szSi6F2LFN/TcdevNu9Mkf6lYCtwcmXu
 US08vqHujnx19RnwnFD1yZKYOclU/xXdqhwmPIFI30jsqYPYpDkWgJtklaoTePesvVYf
 n9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ZlBXp4j95Fesrlj5MUpmODB8sCNBYo55Oy0NCx35Ro0=;
 fh=K4dKwhip0k4jWpyOa/P2mswKYmHj79Z6GUzNQPM4z7I=;
 b=itDQN38boEetcT51zyZPYPQFOcaRBwq+JMXy/Mv+hl23SpUpDIC+zxe0Qtx9CKEsr2
 /LMPg4tcIiypzWxceCFxgnaQqP+8CPv/tIDHM2u7w44p4DV87VgOT7eJN2Qe8ZZz3jI1
 AkT3ZwTAvxgmoYDfMfZdInA0vfr+0Yo8iDxB8A9FOMJAr3IKg1I1QsB6sKKPp6JyAwXy
 0TQTRUdaGHdwz3ReCnmwBWxkcEbMOUUYSPS1ExDXNRrh2S1Qx7v0Yv64HCXvVdTgL++F
 JWQueOt4+scKMeG6d+gtvIVnZc2h20Pnyub+6lu2H7AGrBKVgXCdh2EDUX20Bu1Md65u
 eRJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795492026; x=1796096826; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZlBXp4j95Fesrlj5MUpmODB8sCNBYo55Oy0NCx35Ro0=;
 b=Xh8sqDSudiCo6GMSx7x+MyWLCgTnikuT0Bqd6+1OhR8seC7VSsEyWdsyc6H6lXShY1
 6mpW/nVXSI1sp0C/F3e7uzQWdCsJdSgMLK1mPjJCuUuYqRJloBNQGL4YclX7lNZfaFWO
 Rogk22yEPM1bBAMC842+X9KKlJSPq/KIXOHUZjVviOETYJytt6uDgMyu+TIaJS5Fh3+2
 dZbJdSxjxX78iqQ5acfDlOxhFfPq1vYrUcPwZ/zVSlfLvzDedj8ge0315zATTX+xcbHl
 kJdQ4thKGgwkhzIfnsECh/b0pV8ei2np25NwZG0qWOtFhJTaX6eHaxysFx38J3t2eu+F
 jNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795492026; x=1796096826;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZlBXp4j95Fesrlj5MUpmODB8sCNBYo55Oy0NCx35Ro0=;
 b=rFCRT3XLZnjy2zcb39FPT5SSgu3zhJcZ4M9MhHPPdAppLJTBK5sDk5SGTVP+E5mMLl
 FjAQGGiUBzzQQSFmmR2hWL7OoCo6JGsd2IGLbqcFOdEgfrrG+SBbA6GoxSCo+mDDUc/T
 JczLjq1hclbhuVZJ3iPajFLfIvtYiS9rNzESGPOxpT+74ndJkMUP03G8UA7FOYDpgRPY
 xho4OB/Ad7aCxhgcRx0JkESYzv0rPNqygSva+qwBZtYE7wD/apPdlSE8h1wqMID+vqI1
 mPcO3oj2RjGbBKw5anvXJ8F+NcJVBvOdUtSfFvxFdQs23gi0+eAlouGYNpNKqQQIhBMI
 l50A==
X-Gm-Message-State: APuU4Z8bckg8sGeTC6CD77LDUDNblnZ5cXc3TbW0MUXPPWIztj61qPI/
 x6qIQwVbhdJvisv3s/H858M1xYs6zCW9o9tuUKeFd5C0le2JwmCow31ul0lFTEtusEoZ1SIug7e
 2KOBg6fgv/X0uJECkTGXxFkYiDTQqUfk=
X-Gm-Gg: AZFdTZe6y3Ahu3GgCCFsyYHVgYxGYcqrEZqmWuiHlXVNZROvB6CvXD07zPkdCyvIkjy
 wUpIki+pFnxPs1Yl1+J85i8JDCxpDF/97YNH3wWfcQm6PUcUboy/9Ic0+QWwuKlTKTXolqazJS5
 fzX8hQGclEoYmG1tHkyddq4++ZAIFp5bokb4EXmRO5pZArRnEYfUyZ2vbHzhFmoi30NYADkfiH5
 howcgMO6jQYxnxkz3pUtzjL1YuCJu3Tojns7UhNQisVI7jOm0cnUaYudsQ9zMlKmnMRG9MrrN2m
 S3q9mckz3GlDOsbwxrNU5fFsORrANqx2VKTIOPJOciL5Lwu/ZcxqmLCq/Z3Ywh5g9+WqpvI0avR
 LyrWsJUG63d3JC0ZIDY77X2kyvOqFSNqX5GfMErK0guRCi/7nHa8PuVb7mLb3fN9JkyVllJ4SV1
 Clfiy0i7iEWUm4MQo=
X-Received: by 2002:a05:6214:4e81:b0:91e:dde3:f213 with SMTP id
 6a1803df08f44-92134b0e48dmr208910266d6.40.1795492026210; Mon, 23 Nov 2026
 19:47:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Zhi Long <longzhi@gmail.com>
Date: Tue, 24 Nov 2026 11:46:55 +0800
X-Gm-Features: Aa3M54ovvCtFZ2UeXOS2b1TVyPsCM_DsKH4Wi3KQVJPC-xM1QpPppfUx76jRiWs
Message-ID: <CAGEQorPo=UkuF-o5+c7exvXzaj4uudM_f7ek_6GnSumMyYngdA@mail.gmail.com>
Subject: drm/spacemit: K1 DPU and the K3 display series
To: codykang.hk@gmail.com
Cc: dri-devel@lists.freedesktop.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cody,

Thank you for the K3 display series ("drm/spacemit: add SpacemiT K3
display support", v3).

I have a question about the K1. I work on a device with the K1 (a product
built on the MUSE Pi Pro board) that has a small MIPI DSI panel, and I
would like it to work with a mainline kernel.

I compared the K1 DPU in the vendor kernel with the K3 DPU in your series.
They look like two generations of the same Saturn design:

- The pixel format numbers of the RDMA layers are the same.
- The bits of the pipeline control words are the same (output enable in
  bit 18, the video mode word 0x821).
- The RDMA register block has the same shape, moved by one word.
- The interrupt names are the same.

But the layout is different: the register window is half the size, and the
control, timing, composer and interrupt blocks are at other offsets. The K1
has its timing registers in the output control block, where the K3 has a
separate timing block.

Do you or SpacemiT plan to add the K1 to this driver?

If not, I would like to do it once your series is merged. For now I have a
small local driver for the K1 only, to bring up the panel: one CRTC, one
plane, direct register writes without the command list and the DPU MMU,
plus a driver for the K1 DSI host. It builds but it is not tested on
hardware yet, so I do not send it now. I only want to avoid duplicate work
and to learn which way you prefer:

1. Would a K1 variant fit into your driver, for example with a second
   register map and a second back end next to dpu_saturn_hee.c? In v3 you
   removed the ops table, so I am not sure which structure you want.
2. Is there register documentation for the K1 DPU that can be shared? I
   took several values from the vendor boot loader without knowing what
   they mean.

Thank you,
Long Zhi
