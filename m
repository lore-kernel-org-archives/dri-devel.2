Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943CEC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C8010E1C7;
	Wed,  9 Sep 2026 13:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hw7iofnZ";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE36F10E192
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:07:42 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso175322f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788959261; x=1789564061; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cIISFENV2r2XCrde4HSTQaSrbuJgpNySLxzv3eVQ07w=;
 b=hw7iofnZbFvGS3sYkcLVLQLtgJM3g6At8S6Jz+fpg2l0aagESplm4E5EMgS2Beo3bT
 VkcLq/XAyl81sgyVGfDyIBrgj3z5QkSZz5Bs4j9zjy4texymwNax8hQ9sxsyRI8lhIo6
 4e9rjb9JZh0myEw3RTJMzbA64onQEDaji49rl3DCM78PVjGe0L02VfsY8mEqy+o6GZQV
 iPdfVubFbzeHQ66dq58L7v2YrFlz8TudpXuFlxtppP+TShDMQJvBwkAfeEtbsPhKTWC+
 edVzBk73d8/1Njqdd5rITNKWlT1uMcazuOJ0IdeRGveNIwU0FnDZgjjy6D2Cq3xElKOi
 f9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959261; x=1789564061;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cIISFENV2r2XCrde4HSTQaSrbuJgpNySLxzv3eVQ07w=;
 b=QoUH7HourxIbLW4lDZanpRErk1QhuTlU/1x47GLEOzY03A2y0xj93I0Y4+A1+6kxiC
 ZSIRyOolhy7n93gdyH+eQFV4WQmHWR08W9CIokqCo7YjSShINI1u4JIoICaIpsbrVs07
 dsJdYWjhcr8IMrNMhkMYDaskxgLumEWk7oWeRE+dKZWCnnUaHD07JjZzoDNeKBbtQFE+
 Kpb8vqsWDXZpL8wxNazSPIgxdolGJrkCtOZTy0MB9NRnY8i7YhuT+eVOyPB0zPUo1owe
 LvX3Clk2FM3sp4LOzLlbDfBCZpNcRsLphmr957W6jfHe1HBcxA5jDQVrAXN44TvrDtRF
 dFmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTXYq1hgjOG9GQ33iRkLyN1K4BLCVf7zwPbSwQnmgqQz6WTo/hlZSAUhyzu+zM9kc3jjTMtZVZypY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKqjwvwNa3bH/1PMXnN6JeTIuN0FBx7VQBHr24udkDfjToh7Fo
 askL92QWeGwleZbO7rcDAGmcsTbDPTt/EP3x5cYIs+ZTIMrhjr7A1EcARYGVO/JEy90=
X-Gm-Gg: AYBFou3ufNmEVM1mcv7wQNeaHYWnSbNN/ecEBFHgAfYDeN2ginOjxtb/1i6CK6vwpR8
 nD7/JJ0EJUAz1L/40pTn/rrJV9/0Ih4usDmMuUtUrI/yrKvNRLoUd22Zkd4F2BZPXQW0L42z5qG
 a0rSvu+cYW3vtvjofK3V1n4DcdAR+cZFE6tCSnrCnZbkPqUs5aL4S0JcDBk98tXpYSPZJdi18g3
 KDfIet+WAgAP5jW0x41koDJJzF39Yyy6WIRmFLULGr2BBfHSKwqwGvABZLQttaQXwYZF++Xb+24
 Vs5UqSgEafoZya10dlbWiEg3YJhg6LsSS9sx/cS7WcyyruMNH0adnIagkEb2nKkrMgjHdP2GMMZ
 K+WzUK/U3wxdKxB32z/UOoBTEYJKMza/wyGK9ECXwbKz9jhUt7wRzCuVuIXXdMuvCOfZRF0PTZY
 FMwtx+lLYiakigBuk4058TqfZR+aIpYTew09/i29S8kS+O/o8ob8pnJlZlX8Ox35F8dz7p5LCnU
 sndWWOA6sVU5A06ipg=
X-Received: by 2002:a05:6000:22c5:b0:485:847f:fd9b with SMTP id
 ffacd0b85a97d-485ba5ac3f3mr2264895f8f.6.1788959260993; 
 Wed, 09 Sep 2026 06:07:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm34031175f8f.11.2026.09.09.06.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:07:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] drm/msm/a6xx: use correct timestamp counter on A750 GPU
Date: Wed, 09 Sep 2026 15:07:36 +0200
Message-Id: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhaoWoC/5WOQQ6DIBREr2JY9zdIKmBXvUfjAvUXf1PEAJo2x
 rsX7Qm6m5dM3szKIgbCyK7FygIuFMmPGcSpYN1gRotAfWYmuJC85hqSn6iD6LSsOFg3g1E5JHI
 Yk3ETBLQgUFWqQilU3bNsmgI+6H2s3Jsfx7l9Ypd29d4YKCYfPseNpdx7/y0uJXAQ+qI17yVK3
 d5eNJrgzz5Y1mzb9gX/6Bpn6QAAAA==
X-Change-ID: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Dt6TXHaOCAqPRIHyG23gzZbwlkqfyVrlSnZmGK9PNhA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoVoaUYOK5cYji+iRpHkEtlj5XxUOkOjIna0kvFWK
 Fty7pB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqFaGgAKCRB33NvayMhJ0aDjD/
 9LVjaYE13VUpqoz9aDR9mXIVZ1leeGD7ajm7mmps4uVyy+4P/L+NVuxJVVWAyFViTwQqenY/+Kjw4y
 Bci+MTG1qOeEsv0XSLGVk7lE9GVehq5IBJWbreqMrMdj7uKpR7B8hoR7H5FpxBF1qM1Dqu6/CT+wLy
 jMDC6kqUALrYUBkemzPBVR7f7tRR1O8uXbrbSmjsUY/rBqx90JBU7BbDUnlIGMzLPF8Gw2d0uasZQr
 XfckT6BvCz9riotZ7MwEhVomAXbou2F42rUXwX1p47NZOLP4IT+/+L9ua1c+lnG6vXxPCWh0Qzjgj3
 IEHjpDzLMoIMr6KLqqutoWE7YgcgxXs5Rget635Hj8n6dHlMHyhbKrH1tQ6HdDc84KBbBnwFJ4Xzr4
 03UZbp/wpS5PFLxY4CihyypfI1VMuoTqrCsKK+8dFrE+KEPjwARZ8M5lYejrn3rI+Yo/cYoRnYh/su
 +jNlsD14SeRGBQfzL7AbCU7Bn22t00dSBLzykGA228FBG3ACi5U5oUIACgCDqMs1EkeFQ6mByQ6uYd
 GPfvJFqGiGpIVMTQ3VQ/Hebr6jDEeYFAo5q1IzRp1Y3yIManq0LkqIDpxevdKk8Y7dINwrxPLSVhLW
 wx7i3b5Jq8BTcBRIzGXGKnRIyyENhUkSNKI26vBWcWqlLiVjENDKoUYHmcyQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The A750 uses a different counter register as used on the downstream
driver:

static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
{
...
	/* Always use the GMU AO counter when doing a AHB read */
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
...
}

gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fix swapped H/L registers in XML
- Link to v1: https://patch.msgid.link/20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org

---
Neil Armstrong (2):
      drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
      drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

