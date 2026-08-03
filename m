Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A281C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7192610E036;
	Mon,  3 Aug 2026 15:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwH9Sr5G";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1E510E036
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:44:47 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49544f26c43so2420795e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785771886; x=1786376686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brpCBQVGbNrDVt7cTfK+56VzO28aZ7jJCm8ldakLLGM=;
 b=WwH9Sr5GBU8x2MlkP6OA3alYKFVH6k8fQvYssUpT6D613CYCvBC6i7BhXjFSld7heq
 YCgDQINYsT4JXc/a4D6iclQreHxFPxgXVhxGsYEIwt4P2cyAmiFqU81ubmHi2x5BL0Fz
 axalOedB9e+bxqJmKO974sc+/JpQVSu81ke9s6CN/xxdNH4t5UlqMg11Dy+hiudbF8km
 9vACbMFS95TTBBhl7h2SQAfzqYvE76VYqINHB8a1Gsac/SWLi7Oz4JyZ5h+ZDqXIy6Ib
 HZ55MuEwPPdKyOWN4byva3usKFG7iS3m1PXofLkqjgjtPoBS7Q7bI6CL0w4K8PTAbbb+
 IR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785771886; x=1786376686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=brpCBQVGbNrDVt7cTfK+56VzO28aZ7jJCm8ldakLLGM=;
 b=BIP9rBKiz0QXMOimBkGtFSLyTdeWaHd4JOTUwJvwaermnnT5uUJvGIrSg+ImGk1tHv
 VnSWTvSr8M42NJFUbBV59UrvHKaJdSbfkBLJF5jgRBwVq+buSWJouqYfNLRKy+zDLe8q
 WrOtOj3j8jTYP74ydNTCEJEuCyVvH7VlH6/x7si9NprBZC0J3YyrWL7ITfRAGV63yHUF
 DHTxuHPNFpLzB/+3pWOzNkejAZD1IutNc401JkJmKvdMAGi60RNxi1o0MJzFtnqGhAIK
 cINT024KIhz8kg9KV7FmDoyEgUwkvUsJuBwPRUsP4efJn3vZrwt3sSj3/mOGbkb2EIVs
 0fUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWvrbuA54/jRV8ybFSCXafmg3xwg7h/s3DREOGZSSMctw31pMH+u5A2+BRXM2qR3guYicofgWj3pE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyMH4sShI71yDrplANHOqWnwBbWgoHbrORWcvrR1Gl508JRJu2
 eBqhuE8o5smu99zP9qWlMMakwUKpv6ojnBtBZ5XRKo40ILb1z2PjX293
X-Gm-Gg: AR+sD10Jbh2E4DzoStdY+E/3yyf4WxFtMX20v9Z0xXFj7EZFmp627fDhpZRGbDluyes
 tn0ujDRyJh3SSiJ/hCyRhdiPZribbqjb6wgsRVRVORvbwGke5eTGhzIv9SNYzxilsp5z/arM1k/
 VTEka/KwONdO9nK+v2phFFTwu3EAR4JE61CLD0A+utzFWBgtUo685xWNNvn1yRyCTXR1SIGInfG
 /q7d5HHMMtpfHXH/YFd0zfxpThFCVxYZFuwpkapgKI1vuoIbx6U18hWKwzi+YHNj6KO1zB8LwcB
 dXuP8DQG1jUW4r+nDWB9hjTnZgMuskkd42rk+AZfG0duw2ksK1hRKIlmiY4Y+vyiwzu5IVwd+1M
 hAtYX0tyu4pvKxnDfmjEQipxtQz7od01kHIl6Bo0VCu/PrQJA9SCN4wTI0V7E833B30i0khLeAE
 GWd1ZNwT2z/Nb6PVjA0ehxJtqeoVzcPdwz+HAdh5xAc6Z8tFTBqA2wLVE5iNkigeRpLxzq4J1rs
 dHA7vLoirVjiiS+2EETpwVo20N9degRfS+fajJlBldWQmrsECOMJ7pUnqd1yhp4rtEn
X-Received: by 2002:a05:600c:1c11:b0:495:7561:a9cc with SMTP id
 5b1f17b1804b1-4980c6aa664mr130391355e9.4.1785771885581; 
 Mon, 03 Aug 2026 08:44:45 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b9441csm233512265e9.4.2026.08.03.08.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:44:45 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, alchark@gmail.com,
 chaoyi.chen@rock-chips.com, krzk@kernel.org, will@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/6] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon,  3 Aug 2026 17:44:23 +0200
Message-ID: <20260803154423.12175-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803094125.3285895-5-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
 <20260803094125.3285895-5-gahing@gahingwoo.com>
MIME-Version: 1.0
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

Hi Jiaxing,

Thanks for the re-spin, and thanks for asking about the tag rather than
carrying it over. I went to re-test on RK3588 and stopped at the diff,
because patch 4/6 is not the fixes-only patch the cover describes: it
carries your debugging tree with it.

Diffing v3 4/6 against v4 4/6, rocket_job.c goes from +55 to +306 lines,
and 202 of those added lines are the ping-pong experiment. It brings in
five module parameters that were not in v3:

  state_init  (rocket_core.c)  - default 1, i.e. ON
  sptr_alt    (rocket_job.c)
  snap        (rocket_job.c)
  pp_clear    (rocket_job.c)
  sptr_dbg    (rocket_job.c)

plus rocket_snap_take() with its ioremap() of a hardcoded
ROCKET_SNAP_DPU_PHYS and two kmalloc_array() buffers that are never
freed, and rocket_sptr_patch_regcmd() doing phys_to_virt() on the
IOMMU-mapped regcmd and a hand-rolled dma_sync_sg_for_device(). The
comment above the block says it itself:

  /*
   * EXPERIMENT (not for upstream), 2026-08-01, following Tomeu's
   * suggestion that the block is stuck on ping-pong bank 0.

So I think the trim simply did not catch this hunk.

The part that matters for the tag you asked me about:

  rocket_core_state_init() is called unconditionally from
  rocket_device_runtime_resume(), not behind core->soc->poll_completion
  or any RK3576 check, and rocket_state_init defaults to 1.

So on RK3588 every runtime resume now writes PC BASE_ADDRESS = 0x1 and
the CNA S_POINTER 0 / DATA_SIZE1 / S_POINTER 1 / DATA_SIZE1 / S_POINTER
0x1e sequence, i.e. the RK3576 vendor init replayed on RK3588 silicon.
That is a third change to my board that the cover does not list, and it
is the one I would have to characterise before I could put my name on
anything. "RK3588 never reaches either" is true of the two fixes you
name, but not of this patch as it stands.

The two fixes themselves look right to me, and both are correctly gated:

  * rocket_job_fini() cancelling poll_timer and poll_work under
    soc->poll_completion - RK3588 has poll_completion = false, so it
    cannot regress here.

  * poll_work_seq / poll_seq in rocket_poll_work_fn() - same gate, and
    the stale-work window it closes is real.

So: send a v5 with 4/6 trimmed back to the fixes, and I will re-run the
RK3588 bench and give you the Tested-by on that. It is a mechanical
respin, no new debugging needed from your side.

Two smaller things while I am in there, for whenever the experiment code
does come out anyway:

  * rocket_state_init is not static, so it lands in the global namespace.
  * The two snap buffers and the ioremap are never released, so with
    snap=1 that leaks per module load.

On the real problem: I do not have an RK3576 to poke at, but the shape
you describe - one configuration byte exact forever, a second one
computing nothing, the pointer reading back 1 no matter what we write,
and the 20 KB snapshot differing only in OPERATION_ENABLE - reads to me
less like a register we are failing to write and more like something the
block never re-fetches. The regcmd is DMA'd, so the interesting question
might be whether the second configuration's regcmd is actually being
read by the block at all on the second submit, rather than whether the
bank flipped. If you can get at it, an IOMMU fault trace or a read-side
counter over the regcmd buffer across the two submits would separate
"fetched and ignored" from "never fetched". If it is never fetched, the
bank is a red herring and the ping-pong work has been ruling out the
wrong half of the path.

Happy to run anything you want tried on RK3588 as a control.

Thanks,
Igor
