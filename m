Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208E606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=C2WNYsX2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E925610EBDA;
	Mon, 23 Nov 2026 10:21:22 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AD010EBDA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:21:16 +0000 (UTC)
Message-ID: <54fb42e5-42cc-40d2-9e6b-de88c170484a@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795429273;
 bh=5ugiLH8lIxJwk2DYuuNikhUFR3FPn+L3PzjLMFkEA3U=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=C2WNYsX2VUK9ubAkdBA8l0eMLilWAxyZlFEc2Qvs2xDobxtWLrufuX3r313vblNTE
 eXjlth2bTiE2z/VpKnFsjdzX9O+zQ1LxfA3k3i4FSURIvPLl2qiLg0qZL3ces7qJ2o
 HtKSU5feeEJZ5SFK19lakycAhR7lcjrhR43sDd8E=
Date: Mon, 23 Nov 2026 11:20:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v3 02/11] dt-bindings: phy: amlogic: Add Meson HDMI TX PHY
 binding
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, olteanv@gmail.com,
 sashiko-reviews@lists.linux.dev
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
 <20261121-meson-drm-create-hdmitx-phy-v3-2-f8f471788076@aliel.fr>
 <sashiko-outbox-227302@kernel.org>
 <2d8dd4ba-26ec-4b01-8361-09e6dfcfa5ed@linaro.org>
Content-Language: en-US
In-Reply-To: <2d8dd4ba-26ec-4b01-8361-09e6dfcfa5ed@linaro.org>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 09:06, neil.armstrong@linaro.org wrote:
> On 11/21/26 20:26, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue to consider:
>> - [Low] dt-bindings: phy: amlogic: redundant word binding in commit
>>    subject
>> -- 
>>
>> commit fbd4563b5cd10db3f75db052197f808e3b36bc55
>> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
>>
>> This commit adds a Device Tree binding schema for the HDMI TX PHY
>> found on
>> Amlogic Meson GXBB, GXL, and G12A SoCs.
>>
>>> dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
>>
>> [Severity: Low]
>> The dt-bindings: prefix already indicates that this patch adds a binding,
>> so repeating "binding" at the end of the subject is redundant ("dt-
>> bindings:
>> phy: amlogic: Add Meson HDMI TX PHY").
>>
> 
> Use the "dt-bindings: phy: amlogic: document the Amlogic Meson HDMI TX PHY"

Thanks, I will do that.

-- 
Best regards,
Ronald
