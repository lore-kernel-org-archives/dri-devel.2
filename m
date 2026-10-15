Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A08CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F32B710EBB9;
	Thu, 15 Oct 2026 10:13:32 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE9F10EBB9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:13:27 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso859669f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792059205; x=1792664005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AQIgnnlkDAOMkFcve0wwVpG795qOGakU5OyYPUaHddc=;
 b=L5LvylhS72XcPYAigA4Ch5WVAS4Ike8dy4ivHghBClWQWCFkFPGmrE1KElhe9Y3VDl
 u/211rk257aIJnW5dG83KEVKCCC4L390MRX50cnEjKIHe26mDAS2H5W2GDL6YTwKSRMg
 nWJCrXGIdJrAmEqlAyX9jvSOzu9M3wa/x3wDSOEIlkckdviurHWXD32Ozytlq7Cv4Zek
 mtbKXTwz0DeqnB4vKt/WgOD/9k0XJfsTWT88RJBU0PnjYNege3TV+caGPfas1TsqWtx+
 7OI43Z8YF1S3dTPZ/Ais84PYNhJlyJLEXgYbLzu9HO51st/6PNXYzrmW9vMfRzROMtZp
 vb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059205; x=1792664005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AQIgnnlkDAOMkFcve0wwVpG795qOGakU5OyYPUaHddc=;
 b=0l/2L7xwq8z8kQPrl9iHQ38+zAFLMT06i/++O4CYaioDDRqVOX8g0leJqE+LJqoDBm
 N0mrbw/bnyBpuuzxFzmVmCeHr3swWDH7/lCg2BNlK0QjKgmYm+6P9roG5jWbXsijjP7d
 1mALplvAXSXq8DAx0TkjdHNRMOvtq0uc9Ap4Vv31qwpmpKB+r3CEafs3bC4H07p9YnQ7
 jyifecATDeEngvY+UVh6n2KM2bqpe0gJAJjuCdyA/X2hnbDFPNBV5GoC6AvtTgtLT59C
 yd7ttUfkSNqmd6vHZu4dI6SSKU7YIZ4u7Iax44fceBdZrIgHzB4Os3F0CnBQXQo6DPRj
 uHbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnNxgq6ItF/AY6irg3BcqgZW1rW/nW24D58dL5hGlMByeRrA+FQx1PPzoqAFhNsvCjmz9ec50czaw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwadm6gUFis+GEwZHG5Cnq0Sz1MWP06E8FLTrJ1K4m0+DWpAq7
 2XhoBv6Ov0tpYfTPJ8a0XYKcmAvYcvl5Ez95r8T5YCiRTHWceKSApz8W
X-Gm-Gg: AYBFou0PM4BdL3EGZVEHkfQKwBb3/73xs7gAUR3tTDTNoN3eUqHGvSGgU8ooco8TWs2
 /5/QX+ktIjbkvfSoMYi/+AGH/n2VpR+a9tv7D+1+lbCocJ93gIjgR+U0f1+yojE25SCHeD4UiXX
 8jdKL5jAUwZYbduA8Ke8GrBmM4nEdlJhry0ttVT3NcEqhI7I7s5hEXkTnH2L0sF5sIvHD01R1I6
 XY+N6yT3mxBacHf76v1eZ3+S2sRogJ6yjXpcfXjrywmFl+9pziYmBvTczbwxtC8PumeBXTX/QM9
 cDbD0NfMK3CPCaC1KbipLlFuYEZFA6Y1k1lymGV2n2dXnNZLZ3w78CAkqzJse/enEHBnDBuLdOW
 qKV7hJCLoeEgAV+KZ+mwHIzpaEX4NIxSjEPrGKljwLUpqIfyQaRN+uxgNQwzoeayHTAA8PUmKLk
 uBq2Tqm3YydhdGksCrpCrdRIhvDalKjTrZ0YSjJsAqW44OHOUU3PE3JRnooGXUef+PQGR3PapFZ
 FM3jQI6dprbjzL8woK7wOiMCdPvBH68
X-Received: by 2002:a5d:5e8c:0:b0:48d:ee31:a07b with SMTP id
 ffacd0b85a97d-48dee31a460mr8339355f8f.42.1792059205344; 
 Thu, 15 Oct 2026 03:13:25 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:44fe:89e7:9985:abb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de3f7f8b8sm16924881f8f.35.2026.10.15.03.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:13:24 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: airlied@gmail.com, jesszhan0024@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, simona@ffwll.ch, tzimmermann@suse.de
Cc: osama.abdelkader@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drm/panel: Use managed helpers in DSI panels
Date: Thu, 15 Oct 2026 12:13:24 +0200
Message-ID: <20261015101324.22215-1-osama.abdelkader@gmail.com>
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

Hi All,

Just a gentle ping on this series. It's been many weeks and I wanted to see if anyone has had a chance to review the series.

BR,
Osama
