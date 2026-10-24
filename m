Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B8606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bSPJgQnr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF25510E55A;
	Sat, 24 Oct 2026 23:00:40 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12017112D60
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:42:04 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2241874c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792802523; x=1793407323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XRXSv4fVHsC4ziboqWGIFRRdg8cj1bRHxSMe4gZ92A=;
 b=bSPJgQnrimc553AnyTKW0nJmpyMoyCRSKfUJihzHWgZfUhHG8HIdEPkvGGJ6nGLHPC
 bb5jMMZ45OcCTVF4gWRZOkd0nme+Wxk/4Yxy0mWX3JhW7MQvXL29NMxHeEwDyI1qQvW4
 7j5vX0Lehd++nc93RNXt1YeVjG+ThtnfYtylb9sfmTG63ORDXZlajqEwRWweJKZJfjh3
 w8tV5kNswKjnhWjS9edDiMLt2isfTVEaAEcXN0LzwA2laQPyDgnjVfRrxMvzeHULvAua
 FVdQOiEn/I8KZdhL6YdpJ6PYTHLFHNEsR+ySbZqaw0TVrLkWMFl9FMxD8N97gBT8b/rW
 85IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792802523; x=1793407323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XRXSv4fVHsC4ziboqWGIFRRdg8cj1bRHxSMe4gZ92A=;
 b=GxE1hbhe/QPFRyxFOSYaCg+bWEhcvYwZg8blwRQH7z5zd5KmQP7z35yCyyRBt5N9gG
 3yCNVzf88eN2+suMeDwTP4ribp29rbU4f1vTLImr8/cQ4Dan8eha9OTeBx9EszyRvWqK
 LbPD8nAiMkHHZ9eA+ItBSgTstrj+FH3qLebWNB2ekog0TFyJ+qnieGP6RJD+T8zJD4br
 73cWDJeGDo/R/7oCVXUx5etvozqNa8UDn6p96FnBRWFuBj0/QCw1vgFss07kIXhPOKWg
 brKrfQyuvs/JyWzV/jbf+wo0ApWYoa3denDl2jrd3a9kHTZdqQLMAa+8Lz6w1C+kzUbn
 4ZHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEc8bhPb4OFBcljy/Tn6D8LANlWMnArJj+SyOVL1sgkPGQdv76mUjFPNdsRJvBsG/ifYwLGEzol4E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTCBD0c5jUxew7ptyIiur8fCy06UU2BNLoGgGdwyeeiPc8uQAI
 aqnQexO0RPYN4qVeVYMlicIwsLw5/mwswBcCb9GtNE59egwHna8t7FSP
X-Gm-Gg: AYBFou1e7DZMlP8Vtc0/SNYb+iqZCEq93m2P4OryDYH8PbqOX4QtZeoW0y2rAJjgaVK
 5PS5tRvwKdvyZ6oWvo+NrCdayyGJhf0c9BNtDsqrLJmsv3T+qXgApzz0eOda4/eP0VfMtmAR3+B
 n8mVOliwDiIO2J6cYCxY2b5EyLyec4ZS0tjOobYC6UCz2XwayIQNmCIb3OBFyzr/acbbYJcuWrG
 q7hlKM+Y8IxjCvSMfoXEcINCAHxIdlq7u8OI/VyxHauOIYDy3Vw9CiLExTdYDno7wHpMCct8IUU
 O3Ru6IFjzQF6jM2CncznUCmYO181VlQlW583Q79111Wkd/hcPlh5f0/t+990E9JnyI8ofDinYj4
 axMQlQD7+WC2wCL6ITQpjXi/oIkSqORU+g5dDm8IYrJOycnrlmzXuTXp7tvM8EOWk6SC2qg4vtJ
 2pLX6qeExUlVKYViV41y5RO4JYsMew7nn/jx1fUcSb5yBrpYUm2CMWZSmm1MvG6yfyIK5v6gLfe
 hyaSiwMH/jNxgIB4WRw2idvbUBRi7BbPafmCJmS1EWBNnTQLTc942qKBpLdahNh2JPSf8jCjHUC
 1JAUedaG+HmmZ2AmVjuEO6sbR+81fQiF
X-Received: by 2002:a05:7022:3b8c:b0:190:3950:43e2 with SMTP id
 a92af1059eb24-19933f05581mr963161c88.8.1792802523106; 
 Fri, 23 Oct 2026 17:42:03 -0700 (PDT)
Received: from ryu.remote.fontis.id.au ([2403:5814:a404:0:f5b3:4c58:d5d1:e6e6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a37c88aasm1697548c88.23.2026.10.23.17.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:42:02 -0700 (PDT)
From: lloyd.hazlett@gmail.com
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lloyd Hazlett <lloyd.hazlett@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a driver
Date: Sat, 24 Oct 2026 11:41:07 +1100
Message-ID: <20261024004108.2084140-1-lloyd.hazlett@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lloyd Hazlett <lloyd.hazlett@gmail.com>

> Does this *actually* cause any harm, by the way?
>
> For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
> to a pair of GCC clocks and GCC refers to VDD_CX
>
> and I see these prints, yet:
>
> /sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
> /sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0

I may well be missing something, but on an ASUS Zenbook A14 (x1e80100,
next-20261001) the GCC half of that message does seem to cost
something. The GPU_CC domains here are off as you describe; it is the
GCC ones that stay on.

Every GDSC the firmware hands over enabled is registered powered-on,
genpd records that as stay_on, and genpd_power_off() returns on that
flag before it looks at consumers. So nothing downstream can release
them. Unbinding dwc3-qcom, runtime-suspending the controllers and
booting without pd_ignore_unused each made no difference.

UFS is the clearest case: ufshc@1d84000 is status = "disabled" with no
driver bound, and gcc_ufs_phy_gdsc and gcc_ufs_mem_phy_gdsc still read
"on" through a suspend.

With fw_devlink.sync_state=timeout, seven domains let go - both UFS,
gcc_usb30_tert_gdsc and gcc_usb20_prim_gdsc straight away, and
gcc_usb30_{prim,sec,mp}_gdsc once xhci-hcd and dwc3-qcom are also
allowed to runtime-suspend. Their idle_states show Usage 1, Rejected 0.

Suspend draw on battery, same kernel either side, both windows ~99%
suspended:

  domains held on   23.3 Wh / 21.3 h   1.09 W
  seven released     2.0 Wh /  2.3 h   0.87 W

The windows are very different lengths, so to be clear about which way
that cuts: the long one is the most reliable figure I have for the
held-on case, and shorter runs of that same configuration came out
higher, between 1.1 and 1.7 W. Taking the lowest of them makes ~20%
the conservative reading. It is not the whole problem, since this
machine never reaches cxsd either way. It may relate to your note in
the same mail that cx sits at perf_state 256 "because of USB3 votes":
those GDSCs cannot collapse, so the votes stay.

The same thing happens here with a second device, in case that is
useful:

  qnoc-x1e80100 interconnect-1:       sync_state() pending due to 1dfa000.crypto
  qnoc-x1e80100 1700000.interconnect: sync_state() pending due to 1dfa000.crypto

1dfa000.crypto is enabled in DT but qce is not built here, so it never
probes. Any consumer that never binds seems to do this to its provider,
so the GMU may be the most visible case rather than the only one.

I have not tested the patch itself - the GMU here has no driver bound,
which is what led me to the thread. This is only evidence that the
motivation holds on x1e80100.

Assisted-by: Claude:claude-opus-5 [claude-code]
