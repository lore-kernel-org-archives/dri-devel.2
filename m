Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6EBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E3110E24A;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E477B10E5CE
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:04:20 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-884062f3296so424870b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791644660; x=1792249460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PqwoKExF7hzuaQAhCxVdphwaIay6TpBVh1ij/ZVF6Y8=;
 b=Ss2pbCyumAOffRPkqnHkIrwJLiPYPzqiRkKpHCQyTuB0uzxyq8/KB6ICyw/cA+823f
 TJ8a2GMlplaRfczhWr0FcoCLa7h6bRWjiz34YwslUScn08+773u5M7KoMEHPj4N6IzyA
 HItJMpjk62mSoPwdRmHR5xrY9iW0LFFMI4eOGF/uq7lb6cxEwDDJuQElA0bsQFu4ol5U
 bTsCRsRV+r9SkVGuUT1CxiI8IBdcqq3Nx3XPtSw+BK6niazIniophYfi2ZN+YIRxqH54
 k3IsirbenWGDSra8SkIY0TUJeD3allbyBPP5jd0nI9OhsIWvV9qcewHmJZoY0R3Qp9oO
 R9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791644660; x=1792249460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PqwoKExF7hzuaQAhCxVdphwaIay6TpBVh1ij/ZVF6Y8=;
 b=YPjlBNCnUeh0Lni5ciVVXeuUhqHLumeH0PA0oX+zb8peTz/ABGavwo6tv9LDiIuRXN
 zriI1oxosGj7TWzRMxLF1ncLjYAUN8i1QLRJmayH+QStkAGrd82XZXXtXcipbvo4OWbF
 sYlEMs18nYxiU/AYV8FOysSirrxfFYgsmbfcJaPXO8Brv28nFSZHSJMvssUE7mrHFVpc
 qjfPeQ7M6eY+aAnl9xX987w/FOk+t/TDo0Zb9RV0A+2R3HZdplwc8aihzf3l/KDS2t8f
 HDsjI1si4wkV9Hpo2MKYqpaA2dWHTG1CJlAVwjM3+oWsTC9m/6/Q48kBsO3tqQst3bUW
 BXFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCS6ZhgkZi/p5lP3dvE+3VhRfSqhr3+yjZxxy9/pT10EjFxmSdGMwB8Zkp/gI9BJFlSK03ezCBHPU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxindPVeZk956j+nasaOA6Mf/iZ5vU9edZeT3bChmGA7tknrvy
 Ed0obEr3HmcrdUq7YOfIG37KtE6bO9At8cYAEWOmtu2QDTGt1nD/YyxY
X-Gm-Gg: AYBFou3IdBiHT4UCmWP/7QmhySz89krAauatWeFAhJOUJjz4JcCy+3nz2RI2y+nKge1
 FWG2+RQ/Q4NnQumIMmZ13kkV0oB/F3lirIf/XdIJixufDsrkzt37kKEtWdqLKYxPemfwh1PC2wk
 vMg/nAOOnmEvhXQAjwii9N7rT3/qgUtf7kZXKdRxkgyxh4G1UaKNpxAbgSgFQNuCgt90pk0ViAs
 Gu29JNJI3+co3vT7zShfBmsSNrV65v1heKWqjAuZBfM3J12NN8B969XX6SQNl6kozfFCalpOvpt
 jzpSPGxmTqqSB70XkYYiodKPQxB9P5UCyNGsKX4QVLee8WS4r09xOsni+6pCWnOaPixnGVwrCle
 6d4KYqarQxbcz2KWI3Q6F73P7vNfVJuUHNv1z5y2vvT5RAClNioM+6IWJnz7wPyK3z0TFJvbU/W
 6ewFAvWcy412mLDxq/184phn9/OVTbfG7gFkO0oh53bLOrEAb2fs6j3gPizkdpheh672PE6A==
X-Received: by 2002:a05:6a20:bea6:b0:3e1:5481:5457 with SMTP id
 adf61e73a8af0-3e16bde44c7mr4299571637.31.1791644660094; 
 Sat, 10 Oct 2026 08:04:20 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm2252836b3a.42.2026.10.10.08.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:04:19 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Hillf Danton <hdanton@sina.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sat, 10 Oct 2026 22:04:13 +0700
Message-ID: <20261010150414.16953-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

On 27.09.2026, Dmitry Osipenko wrote:
> kmem_cache is used by GPU drivers to avoid kmalloc stalls in a
> latency-sensitive job-submission code path.

Fair, I'll drop the kzalloc()/kfree() v2 and go back to v1's approach
(one cache, created once).

> The /dev/fb reference doesn't sound right as normally removal of
> framebuffers is required before GPU driver can be unbound. Such bug
> reports should be treated as invalid, BTW [1].

I went and checked, and the /dev/fb angle isn't actually load-bearing
here: two virtio-gpu devices at once hit the same WARN at plain boot,
no remove/rescan or held-open fd involved ("-device virtio-gpu-pci"
twice on the QEMU command line). syzbot's repro happened to go through
the hot-unplug path, but the bug is just "a second virtio-gpu device
probes while the first one's cache is still around."

I also owe a correction: my commit message said
kmem_cache_create() fails and the device doesn't probe. That's wrong.
It WARNs and still returns a cache (merged with the existing one), so
the second device probes fine either way -- I'd just never checked
that claim against the actual behavior of kmem_cache_sanity_check().
The real problem is the duplicate name itself (confuses slabtop, per
the comment next to the check), which is what syzbot and any
panic_on_warn setup flag as a crash.

> Assume the similar "duplicated" kmemcache problem should exists if
> there is more than one virtio-gpu device in a system. I suggest you
> to validate this case and if it has the problem, might be better to
> make kmemcache's static instead of creating dynamically.

Confirmed, and agreed -- I'll send a v3 that's v1's static
module-scope cache again, with the commit message fixed and the
two-device case as the primary trigger.

Thanks,
Nguyen Ngoc Thang
