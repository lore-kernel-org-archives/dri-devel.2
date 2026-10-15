Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F507CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FA310EB9C;
	Thu, 15 Oct 2026 10:06:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3E610EBC1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:06:12 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-487049569b6so3506472f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792058771; x=1792663571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=JJbBCKPwNyur1xKjcaQB2CgJTVviPBDwyawxdyYb5ykQfH5qsiB33Bytcis1sKMg3L
 fMaCj2b+1x+N8ZGu9OntzlIPuG04QD7OEF33hdBaNOx+ZC3r8Gyqj4/cDPLIsuFd6im4
 YLV5fWx+8AzJ4Xmk96jiSTi6HOkv6ksplayQnJTfMrmJAq32CTafCABSnx17p1pIXPTh
 yVTo/pHbcSY5Us/dEIbHMOannr37WinJ86KTqzC6eaTS0SOFdzF9bWhx+4rFLp52vKCd
 jgoJwoeDI+MPfpiMOYIhKEdbLed84nie02a8We85a2OeIPnQ0l+5Zst2QvKBvjLQcx4g
 Z3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058771; x=1792663571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=VGhavtdTG+JQeuuMAIbkP587FrDnFlPC0K+b1PigN1zYCh5jmLkEDhazwpIP2oZEhV
 osaDJVE5zM7zzLAfG4822lVGfxi6rAF/89Tjq1Ioul2YcN0B9vJxTNNsWHW6qV3TFzKb
 TdjZr7kQoIFrHUdSOLwIMxX8SUomTLLNHd7225LFYFF5LdUmbuoRYbzeGuJwqhdpwqDq
 GVtyH8NaaEmLdTRiqDt5KbCNwLgBDgbCfOQ64VHmZNaj7WaMxCxyVfpoV9GwM7BUcY/r
 AqxcNBt5IwVw7unHxmZM9pwUHYfXn79AvSzMlXAFiJcUpij7ly/O0cyyEizxFOzWLqZo
 8JWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1DPRqtF6kS5qNII6Nhd0Usv7QAap0pOGsUcn9Ljo7v0E6Rar0pda5m/ghzB2AulepiBJwm0sa5Ko=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6hl8ZS8FAm46clAYWPIN2gXOymOqquR9NJJhiQGLdGSVtyZZO
 58eidzf05lZ9SsjatZwFI1VBQ7393alPXCkr5AOp7Cw5Q54nt5PXqDvi
X-Gm-Gg: AYBFou1gs4/M+2c4LTbet7OPXvXXGqU5LCUgQkiTk75cCzsdmRm8x0TTdWx9C1A+iJp
 4vSlurLTYrsP6TtF550695HzBGiXopGr+Qm9tTiZY1Qq3WMifIhNZZXnmJJEpO/Emi4cGIlEOSt
 kSmhLkEOaTtCeUAbPvMQQJlhsK1A5UNiXF2tiitAJQs/xR3CglFXYnbiFRC7n0OYZgDkXEs50SH
 i22XMjsz6H4I0Haoy7Vevh3oUmyxPSfCJgV0yobb1L6q2HcP/19qiMjSTkMuooVG5Aj2dCb2BGd
 f8QZ7JU//ldH7NSrXGpw2dEAkTc/FCH1uQdxnSZahTxRBZPAzipOCB72ziRIDcfgCvWCM7Si6hT
 ogK+U+VLvj1k1Z/SQw3S+48KnAX+w6y/ho8Yy14Z1/bJZOfyPe4iMTb84As5Ylqtwv0FMJHHQFN
 wREx5xwwsqTu5g9/IYYqs8zVu3AHo1uTpB8fgbN6Z7OO5ChwXlvZMtrrbVe91Ld+qtDsWl8KtjE
 GPdkCg0YQBAkbGJuGU0/BptVYpkCXk6XDkLRZh/0A==
X-Received: by 2002:a05:600c:8b83:b0:4a1:811c:8064 with SMTP id
 5b1f17b1804b1-4a18e4d5512mr360955355e9.26.1792058770944; 
 Thu, 15 Oct 2026 03:06:10 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:44fe:89e7:9985:abb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd993f34sm64406495e9.11.2026.10.15.03.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:06:10 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: airlied@gmail.com, jesszhan0024@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, simona@ffwll.ch, tzimmermann@suse.de
Cc: osama.abdelkader@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drm/panel: Use managed helpers in DSI panels
Date: Thu, 15 Oct 2026 12:06:09 +0200
Message-ID: <20261015100609.19883-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789994813.git.osama.abdelkader@gmail.com>
References: <cover.1789994813.git.osama.abdelkader@gmail.com>
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

