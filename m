Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E42606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vrCDmBm/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A304510E9BE;
	Sun,  1 Nov 2026 11:58:12 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5274710E0E9
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:10:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so402357f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793369422; x=1793974222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nF6oG7qdYpsHcUJcCpTVAL6/z6SjIIvM80+qHFQC0Tc=;
 b=vrCDmBm/bGJ1LmGOiwoYglJOMWCosmhNUmSGeLzKjyaE6zd4Jn1VKdxaYe6wGZLgu4
 z6JQ7xCNhctc3cuH8qscu1wOWYNY23OcsDW+xhb0pmuNmLlbWJ+ufZWfHc+omneY1BOM
 CRTdo1Eyujbj/6npgWB4DxXYIqEGTJ7FAhu1o5QqzdYiTbk2P6pg57OTs/7Prl4YFb/i
 Iq2cOw52bdSB76C+2+r/mdpD1Ue584LMr/udgO/zOde73aURm1mEsWFv5PappCP390FL
 DNBLl/lbzQ9+tf7E+y5VQGJyPiWxnBYFo0yV8QgMldypxwneT5klZaLT7FknDJeZJRj6
 B5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369422; x=1793974222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nF6oG7qdYpsHcUJcCpTVAL6/z6SjIIvM80+qHFQC0Tc=;
 b=Vn8i58FZ2dTPnuOQZN/waqgmyce/eHLPXf59u0FJyVP+TjoANw99nGkRA47zzrNTZf
 yG+jPKP89A/eqwBGnZBQT9It6SaSn+WCtuqtK0aYOQS4jGhZmQYnW+rd6tfhbbfz1Zqn
 cRfrwqvoSR7w2OXg++qYdnCi/MrRJNuaj2VkHx3nc14sO0Oq7tzSM88N0mThFXb+LRii
 /5F67JBBrj9PNzNRENiW5zgViZBsLPRK1vzkZ4OMWlD3i+xidwJCp3WcOpQo4rG8ddOm
 BmASlobWvm0Ttljta0nnnkSJlrMwidGfegsCJeAKOtYeuGGNd7jJ/wyShQ14Zm+wxujf
 1phQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCnwIb3iIKeKMq2vfrwJSU+9oIVPYknsgzHhVbzujui1yFRxXzraT1Xwn8oNJLEvs3/zuTm29W9Yk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGxfGdlrMsRBexAUGEbL7IIC5y3rD8/6iqaN0G5MZOwkg1rCSx
 gqi9ek0V0WWH2C6plBNvTyYzZHBFz6dKWq2pfWKb+ENi5NjYHlFlIm4k
X-Gm-Gg: AYBFou2deVMZXXo2VeAcBw2JqIBlcQrLqCoRDY7H06Miz5/BOHjd8rIi8v6ujJDMrbm
 kGTsbQhLHpmYUz0ZvJMecj7QEMmV+sXdgF0W7psgW32jkip1WWx72q7z7KAqysOUtpy77pk/j5C
 BxC1B1lHQSdhUtAeyCqag8t0ug5jzCGs71DW0yDIWSPaUxMkNRsFBFuvluvCuJPahe+0V9ssaz5
 kNowpQo253e380zyqUpyiecz+6HaR75MyWy/FbUS2f0+lYdWoDL+X79ed+hvJ3O+PC+HdlqKB2s
 mlRqYppRVXd4qfDlSBWkSYqOp7uOW0p64YrgRwsxy7thVtSbUc0AcJ94aqS7XTGNhX2+mBR5Cgj
 N+vk+XgMQ6DoB3HA9tVZV51p10Krx5vir8qlIGQddc9Tl3TxaCXBoBh30ZuSgxAQCofPWFMpVc1
 RHplheEnklAQhkri3Ja+xi2nINKj1GHciZcD+lRCFzgDdtfNm+fMmA7QjJf3abCfoTs9pjUVLQn
 a1CO9oIYlaLRpcNnnp8801AJZE1f88S2ysGW1kOKcGEVP60exGnggiyo5rlLFz2ecmKHlyOQIsM
 C+v3Hd4FyDcb7jmJtYcKHb7GweM5G2m9AvGG5As31/YwPe2XtPbnhYSax/X1g9pWMifeem3ec1g
 XitbwL5s2
X-Received: by 2002:a5d:6f0e:0:b0:48d:ea67:79d4 with SMTP id
 ffacd0b85a97d-48e6e518c14mr5740707f8f.53.1793369421351; 
 Fri, 30 Oct 2026 07:10:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:39c2:e340:24ce:a263:4d8:38f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm5181973f8f.53.2026.10.30.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:19 -0700 (PDT)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Romain TISSERAND <romain.tisserand@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: use the lane rate for lbcc when
 lanes run faster
Date: Fri, 30 Oct 2026 15:10:18 +0100
Message-ID: <20261030141018.3851266-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e3dc854-b2f5-459c-8267-55e88e87f5b5@rock-chips.com>
References: <20261025142639.3454322-1-romain.tisserand@gmail.com>
 <9e3dc854-b2f5-459c-8267-55e88e87f5b5@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi,

On 10/26/2026 3:17 AM, Chaoyi Chen wrote:
> Adding different glue code for each implementation seems like a good
> idea.
>
> Maybe you should try to add a new callback in dw_mipi_dsi_plat_data ?

Makes sense. For v2 I've dropped the threshold and added an optional
get_hcomponent_lbcc() callback to dw_mipi_dsi_plat_data. The Rockchip
glue implements it from its lane rate, and the other glues keep the
current code since they don't set it.

I've retested on the GPD XD and will send it on November 1st.

Thanks,
Romain
