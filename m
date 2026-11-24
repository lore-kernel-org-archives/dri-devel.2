Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YjcUT2A+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1410810F516;
	Tue, 24 Nov 2026 11:55:56 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B01310F508
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:55:48 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so3757541f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795521346; x=1796126146;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vnwt3Hg75Jqhq/RX3EnfxRob7Sm62Nv/9HL8t2YUaCw=;
 b=YjcUT2A+hGR57P1hGrve3D70LAHe1tOm0873d43SLMJBC2JGvPYa71+WRKTU6eUUxD
 7x5QTBG+l3VvvUdKWrRKPqabkqZJeF+1twyIG9s9pnXcmiev8XhSpRg84gt40q5q2CID
 jyjSmP7n/2shtmbpHBOPWKUXvLttO+xczwnxyRxtEQQcqj1CRVsEs1DlIg7ouDDTwgfU
 ZAzzr4ZX6CaC8+obtLe46dJpx7YmMT74Qv7rSrbcheRxGgB+z57kvyihA3O6fGOWEO2y
 YikuDhfEX8HyBm9OFYP0j5GbEE35GyN3+vF2mkWB+FeDCfY76Ns7UdDulM+FHP6VDgm9
 G/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521346; x=1796126146;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnwt3Hg75Jqhq/RX3EnfxRob7Sm62Nv/9HL8t2YUaCw=;
 b=Mah7+6xe2qBJB4GhAS5RLeb44vGYh59wzWavk74sqluOozg4lzvuzFxmm/G8UjaKD9
 Ege0v5ORCS54cf52EFrgQaFIR098XJfchyxH2ihbwHOASrRm9S05129wNCHCgwKP2A3B
 mVxt42QPN/c6aURWmGupC9ASFY48Ts3FGMUECSeTgLirxdGN8uatzoRK+wlY2o7+ZXqs
 MINJsX68eldQrprLPx06W1sUz2qOVNXaiUn3Zd47wEVD/5WyEzndzSv6FV3291n0wBUA
 ABGyMFCT96IQ3B5z/sEO9m+HbdbR9qEfF9L7FQJeonS6GQv7lxvzdLzqIKYwaDPDEuIi
 r83A==
X-Forwarded-Encrypted: i=1;
 AL+hErFheD15Ssjk8KHouzY8SQ66mcsnIxNnzN/IRBfnbClylkib7dkEo7cUur8E8JFdHXb7mZFWBsQcP2k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z800WB6W2OAFllMKm/EKApYI4l57WY7T87+7X75h5+ttXuOSAea
 oLD/Nsg7RXpqQdPDm0iMtySIH+2Lk3XbrXLNEqORvKO5I08XMFZLH4pLvEdOPLMrgto=
X-Gm-Gg: AZFdTZcnvTObxfierXunZkklT4Z5ht6AiayoEsST8Lyeve+t9MIZwmg9zZAunoPNjij
 I7oAGX/NfzaKNFNTiOARn7FMwurcp3CqRC6K3xQrsDIbbT+cu6FTJguOjmxW3BdHlZVvnFm4SLS
 dakPqFMW7VD8rk5eNYwR+oL3GEXVZ5QzQewElwV+RP/J1XMBWdT1Zs5sy4YXHyTd3b2yKq46zsJ
 Xt+wtP/eeKnOKbuD+zEJfNC+naZmJjYhPBg30IgdcNjPAnbDQXPLEMyqo5u4tU7Hd9dQQvg7Quf
 81aRFJsLYgJmE/AW4utKIg7tQ5rY6wG+vxCh/Cvhqf2oR6VxCjv5s3O+1Aa0Ay8rJRQOuoMuFmE
 z6cdOvDqvfbOEnSJ8k5KwTAvc99jqrcIiO3f8MmZYaFacEP6wB5UOqDAgRsviwwpbb1xFox2eje
 Ln5HHZt/RNiVBwPwseSNN+q040bYcPExe7lBYzHLW6jGa+pc9vuhiqCdEjDkhbKSp7uQL5E7+Pc
 XH7ENOpFXGN4L2w7VVFn/5AOw5OoKh6KISkukwkEEIH4XRlrHY+sGkDx+DthCIHNmSQnAFNp8oB
 +O+kWfdSBTb1yBQjrcysJPJvAVmMhPF5uYC4kb+BxlMXiswlwq8TYliGCMUSUWWroReuW0zTwXa
 jJAG20n1TL3i9PHftg6X72M0=
X-Received: by 2002:a05:6000:428a:b0:4a9:dcdb:2e11 with SMTP id
 ffacd0b85a97d-4abb8406ea4mr29382891f8f.41.1795521346404; 
 Tue, 24 Nov 2026 03:55:46 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm26566053f8f.40.2026.11.24.03.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 03:55:45 -0800 (PST)
Message-ID: <bc4234bb-8901-4d0f-bbf9-66f9715c11a9@baylibre.com>
Date: Tue, 24 Nov 2026 11:55:43 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 8/8] arm64: dts: rockchip: enable the NPU on
 rk3576-rock-4d
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <0bcd73278a4c7a0cb2e1b8bdb9aba306355384cb.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <0bcd73278a4c7a0cb2e1b8bdb9aba306355384cb.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 24/11/2026 00:01, Jiaxing Hu wrote:
> The rail is switched with the domain by commit
> b1bff9ced657 ("pmdomain: rockchip: manage the RK3576 NPU domain supply")
> in the pmdomain tree; without it nothing holds the rail and it is turned
> off as unused.

You can omit this part of the commit message. The dependency is stated
in the cover letter, and domain-supply is standard enough that it
doesn't need specific documentation.
> npu-supply is set because the binding requires it; no driver uses it.

So why does the binding even exist? Is it because it will be needed for
implementing voltage scaling in future?

