Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0945C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B7810EF21;
	Wed,  9 Sep 2026 06:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V93UUwR3";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B33B10EEA0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:17:20 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2db858d60e0so12375425ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788927440; x=1789532240; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qVYV97o5l58xlGQ52U9VOgg72HFRjIwE00grEVewmQU=;
 b=V93UUwR3uyUNG6MKTRc1LBCbQaKOvlszbFVHF+JkEmnDH7/23OrUEUyT4jmhUNW4ZA
 F9VNpns7LITFHHGPu4X5V+1lpjCJIIuXrdhB8WE5bEgNl1obNxmw15wBGYBtsUQmRanw
 qArmIQpZpZxXDW0jjxe3PmVAB5YJLJsCTPUNDY08dfu/QJ1gHYJd9vOkeDcWmviQeJvy
 MbpyLYkINc9j2NZW4GPWIsv6jGbdDsEcsNvsN7hWp8M3Zen8JMogUXpUirIFMBamG2iJ
 cuIwLYCjDYcpJ81NqA0GqE7xMvHrVdMM/iP+ga3HnHAFcvkmov7vUnbWoCqScr+FeYQM
 hhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788927440; x=1789532240;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVYV97o5l58xlGQ52U9VOgg72HFRjIwE00grEVewmQU=;
 b=G/hIKoBOHEm3BiKz+sLzPmUlMM+Yg5wmw/Uh/ZfUiswNhBtoVb1NWy69UdYxQzzw67
 30Ksmk33tw4bgPKdXDlwpt9YuMsADHzPHzrnWQqJe0Z1Xp+BYo6uGr2X3hdORt9+qR4c
 +r2MOh0fIB4vHTV7LiY7Z8dyS40sMTX6gls2F1+Y3YJ+BuzMuOmw/9ixphlOiVccYbNM
 obs89dtVcpV1RUksvIGyfnyiapKIFAT4v/l3TwUZSNc2qpOsJFEfu5aI/EbKtvx+2yV6
 vx+6rI3QeQeVtG6JSqtZrBO/pw2rkbZwI46DkIOcf74sRXRHtMDF3fj5NpwbhJxKpjrt
 UQNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwklmiVuQNLf5ywa/hM4/38zT6EgV9EgK2+xpR4kwGN5eI9hMPrvSbQf8z5TZbfzp7ixd1lYV+8G+E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5xBEPWRr+NacOiU5BiKnPWS5Tatt4rCvNC8kwd0LSfkKgTprd
 p+stRDfotEM1f/iAQuumnWd01W+SQ+P66F3zmhPg3QP7uH8ZrWbpX3fyooThj3jP
X-Gm-Gg: AYBFou0UMRvrRYjgDZ75pLHYLUl+lv1//miL66cXlkT9LX42aXX9ljb0SHxdjuCPorx
 8a2lVRKJfnP1RC9zbkh6ZroQwkbSmaf3s1XJQ2cIANmfd8+oy1B5Av1tp6dcfjNG6dAfMy5BfaQ
 Y7u+UXzNd+KnzceZO87OfH1MOV7uC4yjfSk8rs07pTVMTDWWosPH0ovXrTWvulm+ZxvtTE/KPL6
 X0/HtDXXHtZer32W4IGtaTzSrRdr7szRGzsbShxMTzRQ9RMaDMpWeY1TTaBKg0lDQD4zAiRxkO3
 pAMi/7/TnUuuYZnt1zU/nvyfQH2R4Lxb2tSjo0Xxy9Qmej9LlyMTcEzkD+CKuqQxpq0NHrPGLxu
 6SH8GiLMPjQbQUnbqlZGsaocsYA/0IR1clkYEs4Ftx6YGi1SuozcSEm2ve9XTDPr7mbXn8Elv9N
 ErXRmXsMwIbzphkQGnV6cCnO9BsilQ02OVECBANTInYcl8R+yqOAmH5D7jD1xyINAiygWb9G/KU
 fHf
X-Received: by 2002:a17:90b:4fc5:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-39b26190c25mr48104394a91.6.1788927439562; 
 Tue, 08 Sep 2026 21:17:19 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33688cfc714sm21860832eec.20.2026.09.08.21.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:17:19 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org, dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 pimyn@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
Date: Wed, 09 Sep 2026 04:17:14 -0000
Message-ID: <178892743413.4104952.10436048272479771765@gmail.com>
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Thank you, Leandro!

I have applied your Reviewed-by tag to the commit. Since this also fixes
the boot failure behind google/syzkaller#7805 (the ci-qemu2-arm32
instance currently works around it in kernel config), I am hoping
drm-misc can pick this up.
