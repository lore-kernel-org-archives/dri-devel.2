Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB7606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gguEGFo4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FDB10F03F;
	Sat, 14 Nov 2026 16:25:18 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD88110E72E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:51:51 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so102470066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794624710; x=1795229510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MhJIErRaTVfRxe+/WdgTiC6buoyYG4cHph19YbmHDSc=;
 b=gguEGFo4Bf67glihAZVbNVEZ6M/Yhig3Fk1RiIIC+BWln/cLe181im+hestGCMHkko
 s7q2RxTPMysd5n04U5E+H8wAQ1uqOT3JDUog6yzExhyiqK7DIWQLgTZ/dLHkxhFq3IiL
 j7avTIwljGYiknjcpnGg+baG4PHHahbtg984M6jWXgnilHZ9SWCHPvCi1i69RclRd/CI
 eyM0Q5QvWzB+JTRRcZzVXJhOeSY2m8zw52eDRzPb/YY58ibmfqCFTZv9KROGV0uQt5oI
 d6NbfROIsKez592nsTeC0KguPNUyIKh4nQ1Mb1qEQdMBWkpYnbBPmnNiODKYDU3/GYJd
 DNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794624710; x=1795229510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MhJIErRaTVfRxe+/WdgTiC6buoyYG4cHph19YbmHDSc=;
 b=qDKFuhEA+TD8jAZOLfxFVupmMXuvb1+wu0JpXaSLilo1N9pTqUH5K4vFJdsmVUJxxX
 7o/OFkln9U4QOh/lLGDq3XXD5HG895MzYkfn/iuOzgskIr4c8isaV6Sa3AqmpgKcSbke
 C5LChtrL1UNJda5QzhpuUoOmAmaU67nhmRPnbXPgBUKcnxvFXD+0N1YvneBpWMdyJXDp
 GdQQZAmmKY5jzpmiXZAkhosZAtSoW+VBBrtiLdrsF1vC/YCymyV03GowB7+DsWU/kNjG
 +qOk84U3gmeE+LYGzOQlAavB9ZRAK04jMJnsWHoT8XGOToCAp3Zjso8ZrMBGaLKjqgWS
 rnIg==
X-Forwarded-Encrypted: i=1;
 AL+hErG64ae49BA5Vb/6jHuFjt2NMuikr4hg+5bfOQxwtix7xm2NQAhlWdnfy0M2f66qH3YIRnNY/NzOtZs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TxEmAPRdHnLJo4waZlG3pz0u8H6V5tW59WXsJWeMo2Znt0GE/
 yhuRru4g2AEwrnoojyzPb7jb0EF15wPLCCkFvyQ3asQ3o+kY4bwImFRq
X-Gm-Gg: AYBFou36XSjs5g6EOHc0HczkTrMf656SLwhOTqw/5Zvfuhlz9VcFp9rU8u4wrabMcgh
 tM3HZcCP/N5FlznDYxU6bvCU0iltNNnRQwpYaf0ppRSGrOYqDDIvoago7kEcRM+3piJsNhuz8qy
 N6FoSxnxpew0KyT5QR0FIQ76yb1yV/QKCHb8RAmP94wg5swGaPL3SVz7ZqVGi1V7sBrB8XQEcfp
 dHCN1zDt8SPBObTeIgbS0BnWSWXWQ4W76bsYzoyUu6dlQMQiL/Vg46SDtSW0R48fi9rf/RMwxp+
 4XT4axPrkGbA7Tf8Yl5RtV60c9eZVsUUuNAypzZKD5xiIdM2MVs7MZVkwnL7zixy1HBtlYDSu9w
 m355/QrgomW8QZm4zvceY05wKxM0PVWVpx4AZ1a/vGGBNAyBdVe25Nep+v6cG7k9XAsZq/znhhI
 LWucvZosZYk968Sl8PU6zAAElRwn9k/l8KzU9aXeetQDLF4RZLDuZATre6cnUjenXRklsAQ71wx
 1+1ijf6bin92kIqwSY9nONjktoQ+aNbupfyvcPcUvZnDB7+RD23c8ptoP20AEjzOdu++sPnhZSo
 6Ijosfq3PgrtM06LjR5LA7EUtuMsqDWLs5t2Q63xU9m5UAeGD5vVYe56+7cFHnctk/cr/8Qn2Eh
 kqn28yJOau1RW26HXfyjXwDED9ZWfiVL43Lzjw0C4wLMO
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id
 a640c23a62f3a-c5096370c31mr367846866b.16.1794624709830; 
 Fri, 13 Nov 2026 18:51:49 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b58981sm166556766b.45.2026.11.13.18.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 18:51:49 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com
Subject: Re: [PATCH 7/7] drm/i915/vrr: Allow VRR with the pipe joiner
Date: Sat, 14 Nov 2026 05:51:12 +0300
Message-ID: <20261114025115.2419087-1-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-214052@kernel.org>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-8-elxreno@gmail.com>
 <sashiko-outbox-214052@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 02:24:32AM +0000, sashiko-bot@kernel.org wrote:
> Can allowing vrr.enable on joined pipes trigger a NULL pointer dereference
> in intel_crtc_needs_joined_update() [...]

Yes. I can't reproduce it, no third pipe can be lit on the i915 side of
my machine. v2 will have

+		/* A DDB change can pull in one joined pipe on its own */
+		if (!new_pipe_crtc_state)
+			return false;

> When a joined pipe's DDB allocation changes while VRR is enabled, does
> falling back to per-pipe updates in skl_commit_modeset_enables() break VRR
> push sequencing?

It delays, it does not break: without a push the secondary latches at
the vmax vblank, one frame of up to 1/min refresh later. The cover
letter lists DDB changes among the commits that keep the per pipe
sequence.
