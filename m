Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCA1CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944AD10E3FB;
	Mon, 25 May 2026 06:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQDeqPgQ";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED91B10E0EE
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 13:03:29 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso3996593a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779627809; x=1780232609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kj4rwdcY67VyrdGlOu4L8pJ9Vyfha/VtjkF5I+0OLKM=;
 b=BQDeqPgQMBxj1dJ1M6cZ302XDO7kfb8TfzhqNQL7OzaTsXiGDWeX/AXlcH5jwtRUUs
 yAacIkX3BhdddhTv3X3hlxGvDiexCVAw74tYdeIA4KMvF71FHaolJtg3FthTdHskMeGJ
 lJ7QWDI3YMmHg3cPpV0GaYFOQ/RNy0ReMAoxXMcv4AnhyY7t3886nKLdyfyHS0v9cxpK
 GsHwdd+Ad/U1ltLkVcVBncRZhr9CdtW7hnn1nFnBY4EftQkWosRwN7nYCbZGKWgtM3Ru
 HCO36IrLx7eOcTDRUbIVN9yLNtmyt6KGDPrbtQBq0imBt6oghPFahMMK5YQ9H6B8jPP+
 0GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779627809; x=1780232609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj4rwdcY67VyrdGlOu4L8pJ9Vyfha/VtjkF5I+0OLKM=;
 b=iqcpuH2L/pilzuqqCWVN8Grlh+JWs/8CSY1DxZ5/fOD1kY4C8DckJAsRbGuTOF2Yh2
 NB2zsNDiFD43lwSOm9SE7UVcDYlz6WrjeNZwxjEa1vxO75gd2bhMsjxG2/+jz+g74Gcv
 pIGndFjW8YnuGItt88zfBibnRpzVr2hGUJDbR3c6vKhdCIs9B3rAY54O/ClsG0T/lx/3
 BsiGsFqaOTmlSKtZPF+waZ0OxJvB+Ki0dYGn9vzwspUsZAtwIIT6GrD0DgTM/UYO3vHH
 D7Nu1d2RGZzr43WyGt7ikY9a5sKvaMFCZGQ6F85JttfUbrHyVOMtCnaExvl3hP9d3v3A
 iaLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ99Kzjcjsbm350P8y4byHuXRwEJzH86BG9zJgbOJQ8F/G3VgaSrGxK2Q5QR8Ks615EHSEeO0jLlDvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+MSCCWH8WTXx7Lm7GFqOezIAr3HAK7/0wyKYztRZVKVbcSyib
 z9As7PBh4li0YK8OCOQMNkBQ5wQfrTFUYvcaZlu0cEbxzYGNvucBS2vH
X-Gm-Gg: Acq92OEiEVcJV4oyHoXXP9pXizx3cAlmPMGBf17lvXKe0dTl+gedXQsLIJFeowQUl1L
 5ZDVtEP+MtU+Eb57xnHc5MqzS0XEAHBbKEbaIf0zxHx0ttFj3KrtXaD2x6G1xZVSFRlC5fNWpOx
 vgAK2rKsRb+Phjw4ujVKv/i64B+xFYhX/PmHF7zYs2zltUo9WLL1oS1RU9ic55WGktX5sK+RXd+
 zdY6vAzvo37kDLiuOQlp2kJUYH+G4e9M4UBW/vYcjNVRvdZcqCyGl+lUKganrfO44IbqeNzq9JQ
 EIJE6tJZ2tAyNAMijwN2eSsXV0sXBMlmbQTMaHl4uPetByr9frQou/H61zEFxa7yBhGqnOjCXev
 yrsDpUTXHqoDrVFAzh1mgd9DYGOw0NIb289JxfLq/3yI/VkTwbh4nlADfDLaGuQHLGtq9kXssQc
 pvNLkxcjPV428+Tp4v8tHxPlr3aHSFO8pWC3smWRsIYGWTQlN3RK+gfqTgX0H4J1pe9cX+MlC2B
 TaTbrmhf0zDag12iEOGlGAaURBHQDzTg+jzIruEHK+LmpYvraAqY6f19wxgS1UiDFWVyPgMdI86
 S2+9chRcv6o=
X-Received: by 2002:a05:6a21:4d8d:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3b328e504b4mr10852348637.26.1779627809312; 
 Sun, 24 May 2026 06:03:29 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.193]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8520560ff8sm5759610a12.24.2026.05.24.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 06:03:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: reject DMA commands with uninitialized length
Date: Sun, 24 May 2026 13:03:19 +0000
Message-ID: <20260524130319.12747-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

cmd_state_init() initializes the command state with memset(0xff),
leaving dma->len at U64_MAX to signal missing setup. The only setter
is NPU_SET_DMA0_LEN; if userspace omits this command and issues
NPU_OP_DMA_START, dma->len remains U64_MAX.

In dma_length(), a positive stride added to U64_MAX wraps to a small
value. With size0 == 1, check_mul_overflow() does not trigger and
dma_length() returns 0 instead of U64_MAX. The caller's U64_MAX check
then passes, region_size[] stays 0, and the bounds check in
ethosu_job.c is bypassed, allowing hardware to execute DMA with stale
physical addresses.

Fix by checking for U64_MAX at the start of dma_length() before any
arithmetic, consistent with the sentinel value used throughout the
driver to detect uninitialized fields.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 8e95539da98f..3401883e207f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -164,6 +164,9 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	s8 mode = dma_st->mode;
 	u64 len = dma->len;
 
+	if (len == U64_MAX)
+		return U64_MAX;
+
 	if (mode >= 1) {
 		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
 			return U64_MAX;
-- 
2.53.0

