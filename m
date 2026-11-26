Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3A606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=RzUt/cFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245D3112516;
	Thu, 26 Nov 2026 15:45:04 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503B610E942
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:44:57 +0000 (UTC)
Message-ID: <57d28bc3-04f1-4a86-ba9a-aa851e42610b@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795707894;
 bh=04dcLTbLWG5N5d7t79/Zb1pDQ+FtO2giwNZpa42wm9Q=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=RzUt/cFA0YHKfXN4T41/CPi6x2ah6O7gE/XstF5FnOYX1T84uet60DKZtR7E5seTg
 HFpwgcyCVQTGtMh6z22U0zua9LkkjUIJ3vhk/Gx0Gt1ftqGeS5OSG5K3LAMkWfBwby
 PhIGC35qaKLr/agm8X0j+s2MbCFx7wG8pYDtL6cA=
Date: Thu, 26 Nov 2026 16:43:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v4 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
 <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
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

On 11/26/26 13:04, Ulf Hansson wrote:
> On Mon, Nov 23, 2026 at 8:38 PM Ronald Claveau via B4 Relay
> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>>
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> When a power domain is found already powered on at probe time (typically
>> the VPU domain left enabled by the bootloader), the driver registers the
>> genpd in the ON state with GENPD_FLAG_ALWAYS_ON and never calls
>> meson_ee_pwrc_on(). As a result, the memory power-down bits of the domain
>> are not touched.
>>
>> pwrc_ee_is_powered_off() only checks the top-level sleep bit, so a
>> bootloader that enabled the VPU without waking every memory block
>> leaves those memories powered down, and nothing in the genpd framework
>> will wake them since pm_runtime_resume_and_get() is a no-op for an
>> always-on domain.
>>
>> This is a preparatory change: a following patch drops the explicit
>> HHI_MEM_PD_REG0 write from the meson_dw_hdmi driver, which relies on the
>> power domain to power the HDMITX memory.
> 
> A question, is the target to drop the GENPD_FLAG_ALWAYS_ON bit for
> these PM domains, once the consumer drivers have received proper
> support for runtime PM?
> 

Indeed, that would be the natural follow-up to me.

> In any case, this looks good to me! Do you want me to apply this via
> my pmdomain tree?
> 

Yes please, that is fine to me.

> Kind regards
> Uffe
> 


-- 
Best regards,
Ronald
