Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9856606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q55pvIZY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99A710F438;
	Tue,  3 Nov 2026 08:21:58 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609DC10F26D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:05:05 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35c76e9614aso4926238eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793657104; x=1794261904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YgJaaouQ4HjkbJr/WZG70p3Wwx479oigUB8WJp3RE9g=;
 b=q55pvIZYzEkAlElCuVH3hZoB15gCiX8M+Pirhq232G6x8ZGlC8FDHWJoFxyBJI3aER
 Oeqm20qqFeywJj9su+2YhU19M1kF2Osff8idOstomDGRMLIeQ7PJNyYv7bWTiY4Sp4Nw
 Xzwt1s6r6in2H5XqehqFMCh0bs35Z7Ovqm8UJ96gaaWQu5YnD3D5aOGR2qBmkBDOxpo5
 b7bLPjJ5SBIdi9PQJONPXAweaGQZe4WzG1c8X3vF28PS2aIEBro9t5/HXcm475IBWv6T
 S6MIbb1pcvHml1pBcmkzNUZPgq1Yqj8k1MWWtVyXdpHt30y01Ezd7oSRDeYZ/dJqq5va
 zJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657104; x=1794261904;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YgJaaouQ4HjkbJr/WZG70p3Wwx479oigUB8WJp3RE9g=;
 b=zX2J/0EgiubvZYRU62HEQq18AR212Hk5oOOMDDt696XEYqnuJix5HmAi+YDJlhwQaP
 h+ZY6wIFfyy7K+kkLlxfcgxGXnPBjVd1dWtGLm5Mk6kIb27uGrGuoJYWAfgjFlhClT8l
 UoM5eTjFBwsj9p5BZC4fhzP026peTg9Xq7y+KUIrruOWNK9fBWzP5Gi4CW0MavyAA01s
 xAsvdLtTYReXoOzAuy0QyEkM4iMD4MA+8F4Iwm3PW6ZffW9tPRTQzu7AKZt6cC8447SP
 Vm7mpvgyspFe5zWIuTsg7YTXkFUAnR695L0N0cpS/IS3UUl4NfayvM7bGxxC1y43/3fX
 1WtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx50hFAqyBMVprQA2P9POdMsAKJA0IsoOEhkBtRl1KD5gmgIYuuw6ktSCfirNCpNEts/q6aQGPKirI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrhAe9HKumaVXEAggtsMtjYTlXm3XDoHfKiyor5uKDi5Qnj/Jf
 WxxisKt70/htcY07q0eOR2bNa4bHRJmbZAofFfSAbRILApaFwHM+8YUF
X-Gm-Gg: AYBFou33C3gagIRnqS3URBkOp7jxG6BjNxQfZi59/jA36CxKX3hOYr3iM96ySvuNzP8
 y6E8OVqJskewPxogZBvOQ2EDxLGyCmrqeiUT13EeSOVkyVyOm7X3b9TuHeysAjKsY9iVywZS0gw
 z6ST6NG9rlcWlYfxK8muVsIvuIZHVw2YlZYjZ6uePkt2XYvh1baQSnu3K3B2fScWPuBk8GFeqal
 SzkrFngR6TVGprdKE2BrR39p0WyB7QJEwmIfNwzK1F2/Ozv+9g5/v3OaS24uM9z2uChAuqmDO8M
 hy9BmWY1ONOMhcXS0n8Qu/GgvoBW0ncdWE0Hc7GH1j0wOjcgHvJcjmvYYrwPDhp6EucOgtDhjLL
 +EzGr8SmsqgX1VPcTP6xKjPcNfN1tVQGko7WvsfCq3paKuI0hK7FqWnEOArRKghm9ceAAaxoXG4
 cMytFH4Z1hbqU3FXVSA/s4v6C0UTqn1Z0A4wKWzkWm/G5CkZVq7F05qIq3TcVpmjQA+p0vuYSab
 s+MrFO4BXuIZ+Bf5+gVI94JBlehorTRBBGWvXfjUkVfQgvFW/7MJFwafdDC/W8XlOgnqNcexvzZ
 OHx0W7rBHC3tPUx77YtJm9NUe69UsjcSCtmctjDkVMxa
X-Received: by 2002:a05:7301:b01:b0:36a:20b8:ee9f with SMTP id
 5a478bee46e88-36a42203f98mr15418420eec.1.1793657104432; 
 Mon, 02 Nov 2026 14:05:04 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm43006249eec.20.2026.11.02.14.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:05:03 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
Date: Tue,  3 Nov 2026 07:05:01 +0900
Message-ID: <20261102220501.1704-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <86bf919b-5528-42bb-aa89-b518452ed7a0@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
 <86bf919b-5528-42bb-aa89-b518452ed7a0@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 10:19 AM, Konrad Dybcio wrote:
> LLM is curious whether turning off CTM/GAMMA should trigger a modeset too.
> My hunch is "yes"

Some data for that. I tested 7/10 and this patch on v7.3, on a Lenovo
Y700 Gen 5 (TB323FU, Kaanapali, bonded DSI) with out-of-tree board
support. I counted msm_dsi_host_power_off/on with kprobes.

- A compositor faded a night light filter in and out twice through
  the legacy CTM property. These are blob -> blob updates only. No
  modesets, no visible blink.

- With no compositor running, a small client set the CTM through the
  legacy property ioctl: two rounds of NULL -> A -> B -> A -> NULL.
  No modesets. The CRTC kept its DSPPs after each A -> NULL.

So turning the CTM off does not release the DSPPs. On chips with a
single DSPP, another CRTC asking for a CTM would then fail
dpu_rm_reserve(), as I noted on v4. This run does not cover the first
NULL -> blob on a CRTC without DSPPs.

As with v4, the tree carries out-of-tree SPR (sub-pixel rendering)
support. For the test, dpu_crtc_needs_dspp() also returned true when
SPR is enabled.

Tested-by: Joonhoe Kim <26rote@gmail.com> # Kaanapali

Thanks,
Joonhoe Kim
