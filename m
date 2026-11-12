Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A6606A8B4
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dbx1rULc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F3810EF8C;
	Thu, 12 Nov 2026 07:52:32 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59F710EB63
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:25 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8a0673d9bd2so2550797b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469945; x=1795074745; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MeMBAMo08wUuxPAalzAqVHvt8LiRWsl/qLA1LJ6ugek=;
 b=Dbx1rULciWK9TDZ1TyGkjh9IQgQBgkrO48skXQH/E9QC8Z32O4KjcYQZJZzS390F8K
 Kv/EZnpVjC1C73ZiKuwY7DHVCN/ljQygM+TirXugFa0ygCzyuVrzh5Gb5M+qJIEFHOIQ
 G2Wdv24SbXiKXU+NgOJWexPRrUbmG9HBqcewgJtRlX0ElYIeY09ODxEStGl0V9EmT/2T
 zQLCzMzscyiYFNUf1bBYj1rq3bMYXicxpWuwOV43w/t3DXmqzyQb2Klwb9EExHE8Knjk
 X9mG5QEXtH8j0o5O/b6RCCTu0zz/2AfsYl841DiyrJ2pyr6XGycB04W4ojzGWp4JHdBQ
 9+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469945; x=1795074745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MeMBAMo08wUuxPAalzAqVHvt8LiRWsl/qLA1LJ6ugek=;
 b=MthQv+hzMMI84IK/53Rzm7cuh2mRwDrr1rqBsziGPD7YxuHcLm4lfg/3UDM9nPHaDc
 id8A1YhQXk+euDHYvBi7H8Rqns1eDHekQgTXyPd1aQA+l5MV17YyhFgzdDq8WA38l7za
 hC8BgLtIUGoY5bxR0HxvUSReXDWSbGUNrzfhIoNdoVi60WN8op+gQArVxHsY7AopSMxZ
 uzmJZ6b7QrOwjxFW1jV8NvJVsagMs+Ur16L7kmVZi2DQM/5TGiBokrn7OXRw/3Ulbw05
 L2qi98blXoF1JGf5xjNXvByZYwct+NGjPDXp6aVjFiud+ic0AMQhYThQNqwS8sBqKzjO
 Limg==
X-Forwarded-Encrypted: i=1;
 AL+hErGG28XGGwoh8NnrHcR9/tpO51K3ZO0dlIqTZzTGLzfJNVPbzdGsYeProuMaM2oZr+1yqp06GeAX8Ec=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9xMN6rQ7QdnUZltipwdEhQaMsD6saPXylAxHL41TFNPB03bjsV
 QTU+5BX8oPph/eY8dUWOouFdCtF337Gq+y158QQFjNKWmBDysaLIxt6zKOz3n5ujpGU=
X-Gm-Gg: AYBFou0o2Qw3rbZOD5je4RGHIpgqmRXWrHwMHwDU37cenzRXNi4NwVV4oZwf3pIvIkq
 /v7QXtXjHssxxMjT/2Jy+iYLPj5q3XIWMa0bWiayZYqLiZFdpcwZ182Xje66NM9RDgjn59+BGym
 ETTx3HIqI0hUdlCqH9RT+yiJVWU8OFKESYTLvS64j6p1srw10Mc/Cc/FBFAerGXxl47kvCR7eRM
 BYW0BvKXwGMIfi8VoSFRuGWTSsn/DfLnhku6XKwubb3J/W6RWvQf89Acgivl0KbNJ7S9dSEpxGL
 30PEy4l5R0jM5daRC1Wc1NZzD1KvYBmPnCggTEXEGxzK4GzMC/tsBBnnp0ZxvapflIZkfaJ7acZ
 sgaEStZj2WAdEFk6BhKAT503V0s8Ki2Dn2BikpLYYasX57p7EpPFf1AQbZ/qscDE3A0M82mi62V
 qb/ZlqfVsEqu97rs/VEzBJVL9kNPIjBaiyiLCGo87ZVrTUB2FlKj9jAV53hiOgr3b2aPOv5oJPE
 g+wVl4q7YgbNMuQYd6jW1sxLYxEfdpyioEafpEai27TOZeGciTkdW7M+T8z9yupF+rc0esLdoOn
 y83kVkKx9LvL/0MzgfedOPsDJ8ksUQ==
X-Received: by 2002:a05:6a00:a27:b0:8a0:76ea:36e1 with SMTP id
 d2e1a72fcca58-8bc1887692emr4823477b3a.7.1794469945271; 
 Wed, 11 Nov 2026 23:52:25 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:24 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:03 +0800
Subject: [PATCH 2/8] drm/msm/dpu: do not use DSC merge_3d for writeback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-2-a6a88d928aa4@linaro.org>
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=893;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=JycUzHXZbsiOgnzk6rE/otCXrlxkOXnmr2QsNNi2O6I=;
 b=LQqbXTQ2wMNTqJqqSec4r2cPKc+hwkaUa6aAoVc9FArjsp/chYhwbrHeYXtQunux8vdhNvuWb
 4/TnnWFTb2xDJQ1E2wtc7Zn5+LoI+PVV74D/zYkWWH7p6jg8JhO/6iV
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Writeback does not output DSC-compressed data as it is meaning less.
So reject to use DSC merge_3d for writeback encoder.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 53d0ece792f5..d455845ba14b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -624,6 +624,9 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
 	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
 	int i, intf_count = 0, num_dsc = 0;
 
+	if (dpu_enc->disp_info.intf_type == INTF_WB)
+		return false;
+
 	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
 		if (dpu_enc->phys_encs[i])
 			intf_count++;

-- 
2.53.0

