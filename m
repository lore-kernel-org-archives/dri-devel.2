Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282B606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=boXXImep
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9181411247F;
	Fri, 13 Nov 2026 13:13:05 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05851123FC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:12:59 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3b094e649d3so1128670a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794575579; x=1795180379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMa45R+tCxZf7NGiJEXnK9MPuFreV0vlZ1o7pYt/ZYA=;
 b=boXXImepUcMIontJ8z2eGnSGfdEtGoQl26PwwsZP1qD/I3RBBnHYGvIMVKKOrchh2B
 gWKOJdlRaao9jMmMsUZJt4qj7/xjU79uY6lxugxRI7n01l8L78sk/2H/Be7FxNCgLVlJ
 a4PvsDeQLxS5D8ni7RKz0b3yd5NR+kVQV0C/Pcts0qLmF5fqTpQPikIQqRna++oNZZgT
 K9lKyqZaU3WlHbfvvGA5DMEO1CMGQxIEqJpmhOEfYub+I7WcHmb4xaIT68GD8EVhw14W
 zZTbW/XD9AvZpVk5FmDfwK0A25/Ya9vQoEWDs5/kU2eq8LGb+fS+OxWbD+162TL/Sg3L
 VHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575579; x=1795180379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMa45R+tCxZf7NGiJEXnK9MPuFreV0vlZ1o7pYt/ZYA=;
 b=VqKpEqGCI6DzjDGizX5G5uFEhpQH8KAzo001xpp+ucqSiyJXYMVmZ2NNsTGKUYzZkv
 k6Fi2HBBG4cuji/WPBoQZJXdbLu38r8OAdvZfR1CxCY0X3weD7sFmnRGSxGB2SBiPvbV
 vYwKo12zhEXbw7D/wJScuKDnZOduNbkEDEhcpFl/20uN4VFeGVwnFSUa3KTBG+5fYZkL
 8xbuAkmS5jvaTErmfPQ2/rqFgorIYJpfF79sALUW+9Gg4CGF/oGy7daBWSPizg0MFHdS
 rjPGgkyUuPS2X0qO6K/O87Jlkl03DSyU9n1FcoipGF1fMeo6+JAvezlJ7LKppPlriNUB
 Vxlw==
X-Forwarded-Encrypted: i=1;
 AL+hErG75LGQuwBLWLF09TZDA56uY8KEAxpO28PB6dzZKy7HEQxOfE8M7v+hcDZNHnQPyzAhbBcVdVP1eWs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9k9ZcpB05mMXtp7CvPqkOOUKlhJ/DuLAWz9VGSK//TbNPBmose
 26eLg+WfV+uO0I/f9xaDofxn49qeNFoiYZMRqBtqjwrhlGWaokrYWY4k
X-Gm-Gg: AYBFou1nWNJ7pLA7I7QDrvoEec9h9pwkbNd8akEvZHvYyi32Znzxium+8NhuRikdfWj
 RbKDooWkDeniLM3HgwqpbVZHdZjOOx3/Buk+wjEu4ZEumcEdXVZzxBM9cHgj0aC8OVR+3FSbB1B
 AAD2vF3s5BqJX0iBIdw6+hhXiSHLasZVcUYv/qUgxnSIopNWhlFBBVzbGCX6cVoqbHYu6vpd2qa
 x33hmxFK7ex0Y52g+kRB9AWyaNkFRSe1VwSZngfpfVPBgQuOLoLJ4eJUzklLKx4mXZ6nKe9WodC
 MOSF8iCszHPv6yQ107XiiDp+SM5vC9NAMHCAwPpR9sYRuXch/g+7G3gt9VvLE1P3D9W3Q6PVdVH
 YP+UN3ay4z/bgjTfn96c3InZu7wo5+B5HmrvMCYjX3S1QggvgY1wvzJvumbllJNGNvoebOtlbym
 kZF+YCL/vwRCYsDAFJTh4A4UPZUxAAp96mzTimdh57VrLExDZ9oPbnl7kLCQk6pZh6kd4vf+Pwr
 +XUYK0CEumtBAuretifiOExiEEidjtp67ytEe3NnqlOqexPUICYABaI4GTMWyKcFQzhYzi+R0um
 hzxnsA7WSccFhqMgix57FpkpJgnmb2hOzLMUj3w=
X-Received: by 2002:a17:90b:2642:b0:3b0:9162:948e with SMTP id
 98e67ed59e1d1-3b1b0ba0a60mr1992696a91.27.1794575579407; 
 Fri, 13 Nov 2026 05:12:59 -0800 (PST)
Received: from arch.localdomain ([152.175.35.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec622b6sm4931622a91.11.2026.11.13.05.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:12:58 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: damon.ding@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org, heiko@sntech.de,
 jernej.skrabec@gmail.com, jerrysteve1101@gmail.com, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
Subject: Re: [PATCH v3] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
Date: Fri, 13 Nov 2026 21:12:48 +0800
Message-ID: <20261113131248.2804840-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <385a67f0-e5cd-4dba-9b9c-5b766462c6c0@rock-chips.com>
References: <385a67f0-e5cd-4dba-9b9c-5b766462c6c0@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Damon,

> You are right, this is really a valid concern.
>
> If CONFIG_GENERIC_PHY is disabled, the old code could still proceed and
> keep the driver probing, while the new version would return an error
> directly.

-ENOSYS can only come from the !CONFIG_GENERIC_PHY stubs in
include/linux/phy/phy.h; the real implementation in drivers/phy/phy-core.c
never returns it. And the stub for the optional variant returns NULL, not
-ENOSYS:

    static inline struct phy *devm_phy_optional_get(struct device *dev,
                                                    const char *string)
    {
            return NULL;
    }

So with CONFIG_GENERIC_PHY disabled the PHY is still treated as absent
(NULL), exactly as the old -ENOSYS branch did. With CONFIG_GENERIC_PHY
enabled, -ENOSYS cannot occur, devm_phy_optional_get() turns -ENODEV into
NULL, and any other error is still propagated - same as the open-coded
check.

> It should be better to keep the -ENOSYS handling to preserve the
> original behavior.

Overall the behaviour is unchanged in both configurations, so no separate
handling is needed.

Best regards,
Jun Yan
