Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63007C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1FB10EFAC;
	Wed, 12 Aug 2026 13:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xh3bFMqF";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C337110EFAC
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:03:31 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f502ff678so101839f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539810; x=1787144610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=as36wFWfEYJzqaxcovAhzmJbolrDk8C4787yYGJjYG8=;
 b=Xh3bFMqFGCgMVnu/3Xm9fWdVTIvlyDvpz4xnob1GW5QQbUcw6Bxs/CMgNe43LaGBva
 A21BdzIh4qQvSbNQAGqGTO6WKP6A/LTIHFTDmhy10j8QyixoUv7z3p4hUXqH1tYXUxBN
 LOEjvHhd5vX3yIYvofcyYT9WK/4dWi5Pecin7RfDlTkQuFX6SzVsZSvkWwp0EwAw93WU
 sySZla0E/0JhMSBGVR7i8CP5fv72aofGYJXyH+MkMSgCAw3+btoaTKI3uJD7B7sjiThy
 ofDiCCanD89x29Kin19oH+faXylAm+U09PHn6sa+V+XHD0gRfeSnqJV88JM6k9aSm1Fx
 0p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539810; x=1787144610;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=as36wFWfEYJzqaxcovAhzmJbolrDk8C4787yYGJjYG8=;
 b=jWgTLtH3i0zefizZ6UCXaE1nmLhE0NMG/ajkFZdKbkvQqWJN29lczLq8MnMjcCcB2g
 jjjonPrIRK+SFfZG/qQrZi+nTf3F5HUY7bFQJiGD32jxA8hk0ycnMwQCPMvl2XQTTAUP
 XietcthaifiwYn461N/ycQPxauP3VTkzLhSOIEJKeilwfNBjza+yjlOzZR7bZPyaXlRP
 mwzNjvPc2wUtk1RpBgdzWC0E1CmjHokGQwizJtLCXz0vm4V4p7P1nFN0m4+lYjTWlGYJ
 qaHhCCyfMjq4HGnVuSC6q4Hy7jBIMrQfwm8z9sHwtfGJuwnGnxDIudriaELSATAHjTQ+
 03HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIMPJfEe60zr5eohsVvmWY5q2xwkBEBic8HjGV+u8pr2P3SjCdZa5FBCo9XLOtS54d1dzh8Lzi/UU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzb8C5RBZIqR/l29bFiqxfRsX/wVOvWBrJ4uhGYK1Rmy44LjxVp
 MH1zWvpgIA1WcpQH/zBmr1BP4zH3BxFRkyWYC2ugons8jmbCNNoBPgr8
X-Gm-Gg: AR+sD11H47YYaSNR9uZbyXnUM7Hh7lcLYgRzCw3/E7sLj1L2F0Z7u4IVujTjMMF0rmc
 /X79zXPVx8rsqt1zPeYhTvOePaEoCwwKCcm+egsvxmNwCR4Tncm/XokbQyuP/kPYVDftmw+oHpk
 aGLBYCsP58je1JcLr9Dm0LDq5AyIHqlRzD7w2byCjtwUdJDE5hgRcqbP/cxstVtMa0y/jqBKtRD
 Wj2yLAmV6+0ox0pZQTeWp67nZuU9kwfhjj7JkCDfbyMNEZOYPZZMg2z3X77WAJ3Cjg7AbNlg/Ri
 TDlTvcxphEal3oVoR1nSHA6sgq3PIamqaDhzblXIPvzN94WRy6GIF+2WxfjL+W7K6lZW/DFSynT
 o4H1g9Psz/Qb8oBXuAaaKmliySk/m2n/8hX5M0UuBxuJyNHS/DxtosIQCAwkuiCW8cZ2nQpaXBH
 3uLTSLcqgiJB30uq/CLpVT83AteczFs9Q6EGqvfC1mocF1yqgnJS5cV0I/j1u7NxHG692qHyd3W
 c7MmvCeyfsi4JssRHni0d1zTIE3tITaEg1rW1Bt/I4IwTbxgHGmMaLOGSVuw+b9QJT6
X-Received: by 2002:a5d:64e6:0:b0:47f:e8af:7687 with SMTP id
 ffacd0b85a97d-481528da9a6mr3640852f8f.1.1786539809937; 
 Wed, 12 Aug 2026 06:03:29 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu.
 [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5cd2esm7316360f8f.26.2026.08.12.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:03:29 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] accel/rocket: fix shared-device lifecycle on probe
 failure and unbind
Date: Wed, 12 Aug 2026 15:03:04 +0200
Message-ID: <20260812130311.8252-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731064933.12548-1-royalnet026@gmail.com>
References: <20260731064933.12548-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Tomeu,

A ping on this one. It has been on the list since 31 July and 2/2
carries Jiaxing's Reviewed-by.

I am pinging now rather than just waiting because the failure it
describes stopped being a code reading yesterday. I hit it on hardware
while testing Jiaxing's v7 RK3576 series on RK3588, on a tree that did
not have this series applied.

The sequence is the one 2/2 predicts: unbind core 0 while cores 1 and 2
stay bound, then bind it back. What happens without these patches, on
an Orange Pi 5 Plus with all three NPU cores:

  - the returning core takes the index of a core that is still live.
    The driver prints

      rocket fdab0000.npu: Rockchip NPU core 2 version: 1179210309

    for the device that is physically core 0;

  - inference stops being correct. The same MobileNet V1 input that
    classified as "military uniform" before the rebind classifies as
    "toilet tissue" after it, and the oracle hashes change with it;

  - throughput falls from 88.6 to 1.9 inferences per second, and core 0
    stops taking interrupts entirely - 0.00 per inference where it had
    been taking 41.74 - while core 1 absorbs everything;

  - the next unbind then dies. Ten "NPU job timed out" in a row,
    followed by

      Unable to handle kernel paging request at virtual address
      dead000000000122
      pc : destroy_workqueue+0x1b8/0x3e0
      Call trace:
       destroy_workqueue+0x1b8/0x3e0
       drm_sched_fini+0x178/0x1a8 [gpu_sched]
       rocket_job_fini+0x28/0x60 [rocket]
       rocket_core_fini+0x4c/0x78 [rocket]
       rocket_remove+0x6c/0x150 [rocket]
       ... unbind_store

    That is LIST_POISON2 being dereferenced. The sysfs write never
    returns, the task is in uninterruptible sleep and cannot be killed,
    and the machine needs a reboot.

That is the second bullet of 2/2's commit message happening: the bind
reuses the index of a still-live core and overwrites its slot while its
IRQ handler and its DRM scheduler are still active.

With the two patches applied and nothing else changed, the same
sequence - core 2 out and back, core 0 out and back, all three out and
all three back - runs clean. Twelve inference runs across two modules,
one oracle hash for all of them, correct classification every time, and
nothing in dmesg beyond the probe messages.

I am happy to resend with the tag collected if that is easier. There
is also a practical reason to have it in: the three-core RK3588 test
that Jiaxing asked for on his v7 cannot run to completion on a tree
without this, because the core-0 rebind step is what trips it.

Thanks,
Igor
