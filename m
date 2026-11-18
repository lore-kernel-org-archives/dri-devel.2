Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81945606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=DZPLUL18
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4CC10FC7D;
	Thu, 19 Nov 2026 07:48:46 +0000 (UTC)
X-Greylist: delayed 422 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 19:17:48 UTC
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249E810FFB1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:17:48 +0000 (UTC)
Message-ID: <f0c5f3ae-5a37-4f38-bd32-6191a6a98485@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795029044;
 bh=y9UgIWQynPgPoVUM6/yn261u+b/dkSIroE44iaL3T2g=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=DZPLUL186iJM63saUsDmf+QkaMlJDFQ0b3i6Pn4Ivn7rDVbd+CdgMfNGuJ5E61TgN
 4nqWYMEs0NZYMTWbpqLapborXRKZ7R0tLvAAFshU3+Irce7MP/AlT4f3tisXyihh+g
 56re9lp/cNYBe2c8rEQimJQQU13wKmVciZzaOq40=
Date: Wed, 18 Nov 2026 20:10:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH 05/10] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 phys and phy-names
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-5-9e0ac931381c@aliel.fr>
 <3e82658f-1152-4c98-b996-242abc203f74@linaro.org>
Content-Language: en-US
In-Reply-To: <3e82658f-1152-4c98-b996-242abc203f74@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 13:34, Neil Armstrong wrote:
> On 11/17/26 20:33, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> The HDMI TX PHY now has its own binding and driver. Describe the link
>> between the HDMI TX controller and its PHY with a "phys" property
>> holding a single phandle, named "hdmi" through "phy-names", and update
>> the example accordingly.
>>
>> The properties are optional so that existing DT, which do not describe
>> the PHY, keep validating; the driver falls back to creating the PHY
>> itself in that case.
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml        |
>> 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-
>> dw-hdmi.yaml b/Documentation/devicetree/bindings/display/
>> amlogic,meson-dw-hdmi.yaml
>> index 416fe263ac92..5a033fec21b0 100644
>> --- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-
>> hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-
>> hdmi.yaml
>> @@ -108,6 +108,12 @@ properties:
>>       sound-name-prefix: true
>>   +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: hdmi
> 
> I don't think phys-name is necessary here.

Ok, I will drop phy-names and use NULL as name in the driver instead.

> 
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -136,6 +142,8 @@ examples:
>>           power-domains = <&pd_vpu>;
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> +        phys = <&hdmi_tx_phy>;
>> +        phy-names = "hdmi";
>>             /* VPU VENC Input */
>>           hdmi_tx_venc_port: port@0 {
>>
> 


-- 
Best regards,
Ronald
