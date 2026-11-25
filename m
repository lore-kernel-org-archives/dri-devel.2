Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C9606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S/AiRQ5v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B922E112123;
	Thu, 26 Nov 2026 08:11:04 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E6C10E391
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:10:51 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4aa5833c263so5212241f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1795594250; x=1796199050;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YVCS8IMOn/kwNHYEAA1+rZv+hhTaZu2a0obFMQzn71w=;
 b=S/AiRQ5v/n2aaAoy9h1hPcafFFerFWHgkkc80uDGDxOWivgzHUM6rRz/zAHz6hEz7D
 hV+UPzispwswVE+xQj9DCm1z3GiNn+WzF9r5ssbh770a43DN4nuGRFnFOr+M0Ql3RvUA
 qCmABYovBnutWNrGoYlifvTaGWaGIi9WTx1ZiGsxppUfbS4Bh746TlSLn5RQe9FkcDz1
 PktUcXuJXpT/UVKNi56mo3kNfRufcQwyui+aeKuNjrryqtYNpf5OaifVTKWhr8VYkSwl
 VxN1KDQjsWUfB5fnFEXlxpuXeBtZAq507bNR1xtyJs/R7A0Scp9goQ/bg9jq41mZKMjd
 zDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795594250; x=1796199050;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YVCS8IMOn/kwNHYEAA1+rZv+hhTaZu2a0obFMQzn71w=;
 b=Gmsyib8aF67kkr6KB+GSAhw39OwkKeR9zqO1/Hm+WBw/lZtQAdypxDCg1Ng/SK632e
 4UPl/RRMKu2UnIGM3ag9ddmEXSDOFcw+4SAHgHvphjd7U196kkBUN68stB6TB5jsY2bm
 b/6XmgHSciuLmbhDQAowxhtS87lMkDiDH9Jn5r5Wbqy6/h3oVzBOTPn0J1oChtsjcHSl
 4AcBkY7VnQJT39hhwdD9lWBvKdqfv0s6ENdF90gyw5Iz1QctkeRUcgqBMGiWUJ/IqbKB
 wKo/LVuzpCJFRj6JZ94uD+MXZfc6wBFbO2rLhme0X9hh8dpllVO2vY64zldQs21fq8v9
 1N4w==
X-Forwarded-Encrypted: i=1;
 AL+hErHoG7bdbVdzhjtO5+7/xU3eRXp1UGl49Cuv866zJGfYsZdzmlTNZCYMfz1OohZnIspzCOElcCg8Was=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/fOltC+a85J++is+QZfvw+rHWOkGkDJQJWbLYHphjeGOiGv0HL
 eca5VeszP3e2e5oKMSDVChYnpuMonRAcJNIeRa4X2mynnkXUpAFtKv/OmZHbVH8EBg4=
X-Gm-Gg: AZFdTZfaw2QISLZzDBbUrSdxMYys8ZfpVczYl51l8fekWzn7Rwm3VdRTTGiniPc4J46
 4A4goiQP6OmkkrP8lXcfwbnNe1pYZ9Wm/xjeIXYvpMXVhdNcE0UQTGDMlERHCEGgDKJCELoPzKL
 5sBPnTeoAa3hzi+LikmBy2IEFjDipT9ciGqsogDQ3oVEHjq7CHGWnty10jEmY8sSGp12NV/eRC1
 ZZQqfYOIAdVeOtBZeX6/Ai+4+gnXTQuEUfCUL6pc92TY5JvoKIETEphYYrDABaovEFJrCM49nEi
 5zSarNFhbInOVe6XuU/98WS8zDHdhtB+QOVlUAOji+yEbd9b20xPd5IO79KZqm183W/cmnE6UeZ
 WoPn8LnuVKKqNJfo9LRYfSda8wxSgdmP5btie1DC99OAdP+sL1aKoW5LgmY4YseSLTPYR0Wf0cg
 kXGV/8W6m6T8Z8T00bgXVVhIaS42JM6UmVK5/G5OtOBMxyojDmcqXogM0kC4lGyxUavStChAa0n
 xZCq5ES800KJLItsp8xxiGDacqKCqeMd0kiTTDFxGvmSF5JPv+rvrXNFZs+HqBFo6LErirwL8PP
 wVUJifpp1RkYjQ3N0qjB2KjKfkSCsxefXZNVPduJYKOfDcgr5vCBEwNumxXTtWNN84PZdS6poHA
 =
X-Received: by 2002:a5d:5f93:0:b0:4a5:33ad:871a with SMTP id
 ffacd0b85a97d-4aba56f470cmr32677127f8f.0.1795594250026; 
 Wed, 25 Nov 2026 00:10:50 -0800 (PST)
Received: from [192.168.2.69] (162.40.150.83.ftth.as8758.net. [83.150.40.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm31415134f8f.0.2026.11.25.00.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 00:10:49 -0800 (PST)
Message-ID: <f7fe449e-5dd9-4476-9f1a-100466dc0c8f@bytesatwork.ch>
Date: Wed, 25 Nov 2026 09:10:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: freescale: imx93: Add MIPI DSI
 controller node
To: Francesco Dolcini <francesco@dolcini.it>, Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Michael Walle
 <mwalle@kernel.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
 <20261111133119.1063210-4-frank.obergfell@bytesatwork.ch>
 <20261124201110.GA366860@francesco-nb>
Content-Language: en-US
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
In-Reply-To: <20261124201110.GA366860@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

Thanks for the feedback and the offer to review/test!

Frank Li actually just applied patch 3/5 (the i.MX93 MIPI DSI controller 
node) to his tree. The remaining patches (dt-bindings and board DTS) are 
currently waiting for the Youritech et050fw01-kt panel driver patch to 
be picked up on the DRM/panel side so we don't introduce broken 
dt-binding references.

Any additional Tested-by or Reviewed-by tags on the remaining patches 
(or the panel patch) would definitely be very welcome.

Best regards,
Frank

On 24/11/2026 21:11, Francesco Dolcini wrote:
> Hello Frank (both),
>
> On Wed, Nov 11, 2026 at 02:31:17PM +0100, Frank Obergfell wrote:
>> Add dsi node to the i.MX93 for support with mipi dsi panels.
>>
>> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
> I am not sure if the other patches of the series are ready to be merged
> or not, but this seems a patch we should merge in any case so that we
> enable other users of the DSI interface of the imx93.
>
> What do you think? What's the plan for this series?
>
> (yes, I could test and review it to help, I know :-)
>
> Francesco
>
