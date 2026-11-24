Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D632606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bptKuawZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC35410E22C;
	Tue, 24 Nov 2026 09:53:18 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9BC10F40F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:53:12 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2665390f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795513991; x=1796118791;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s3HEy2luFzOKtpXEMJaCVU6qsnBsmUBR+KRo1CZ+Kxc=;
 b=bptKuawZyhXSueVhmkNgnKW79dU6hVOh4pKfRNdHgTCPvjItOGtymi8dn/jC/9mAU3
 W/32Il09g679Vp4QBkE4RrL+AKzHKQbqLvH1z6KUGdkJlXQraN96hLCx8HW27lDX/+g9
 kBqFfvZ6JEIk3X6Q8xEdBwls18ms67SqzVwMeYHH2sXO2wQ13/IlI2tXDoyic/Iv+uZ6
 3Wol6Qlr87nTuqeLZqrrsGYesxljidrC+TJyRzchLaBI0zVlLNEjW4vj2/IH2d59nc0Q
 a4H1RZDhtdsWT0LBiZZxO8GljK+LhRb4JT70GO7nS4cP7zuAJm+Q68CG+xOBPxpUd0Dp
 mz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795513991; x=1796118791;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s3HEy2luFzOKtpXEMJaCVU6qsnBsmUBR+KRo1CZ+Kxc=;
 b=cO9+GehWHzCuPsjSKxUn+wYHOdDbGzfV1oRBzjD/8IllqBlOKeIKErtdYD91R4oJfJ
 9yd8l9c4JU8i4THP7Dz2jaupuP1IOTYjzAtqPhDRowWyreGx7aVVQaOcQQPFXqh2uU/2
 mk/ILhwNwQ7NmRwTXr6pnCNTbRC71XNWIXrL6zT3APZQLKHkgJ2/H+gNDCYaJHSaEiaB
 AgTk/NJDiKkZG0ZDyOAyEtiFOmN5IFx9CM7PqtOyc5Oyrb04iqCVQxLl5zjkgjWdZmmC
 i23dokoY3lKLVBcQzRC3T84o2FmE4t/vfwLwGDVDZx5GrLq5Cy57ck/TB1VbRVZVJsio
 7oKg==
X-Forwarded-Encrypted: i=1;
 AL+hErF61MTZYXXVoUvO91Xmc/GcqzOh+U4scunKMxLZ+ooXbfajTsK7CszkHer3ko9OKV5PcYGsrMXXg0o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9t2laLHp4F13rvfhOaC/wpmb2TgHFMpz2PLCC/xXM5QBh70CKZ
 aqbdW8pTVwvxKlpn1ZVkKOISjl9+tsERJNAu2ATCpZ6xy9QkCKTlKxtvUa2NqwvmRXI=
X-Gm-Gg: AZFdTZd9M1KAm7JsNlWV/qRnv1BBancuxJ2JVuNQVSxz+59kseq/yDGWOWrg7Hf5l59
 2jM0FCPLRnXOrEoSSujxxeY9ZesGPsGrlaMSb93ZCTG9hPX48/JfITL+VDb2j0redmGc136M0Ov
 aIWKIELePAkMuECqxfVynVhMfDZ55foFxPXK0fSRJncq7jgJ9N0kQgmZU/1zCmW4JX8+guC6058
 51qkqSCtah3fUA/pJJDVC3stlkUIV5INfVrh4oTIpWdqYXqQGWQUEudzJMnsiv/oREA+QKNwo3D
 FxtPjMUe/XceOsRQRN/wbwUTi4iiUD/dND/kEXB9atgMeTC65pn4KvTOD6IeBdA3OEx7Ji8/LN7
 YDn/iiCCk8fbDokwkdUnbz+LCzbFtf1IPJ5bCdF0JVU3KpQ3ydnr7p/zftV9HxRMQZe6+/JN457
 6yPuOw++6C7KwCa3xW67zxnnGaMk33n4DkSBIxW94T7i4J6uKs2pWkV6JSPBZNMsLejXXhAI90J
 6y9QTbIfIIlziuLyaqI3rTeyLc0v/8EOGFcuI9JWYUw5bD3EcPsUst5BSkvQlSY9IiJf2Kjhujp
 thFDRvovuron7RVxz1IaFdhz3k0/wm/DKEgWkyjpCvmt/vmpc4DE+jbrZuBZCjwd3ru++gV1yVD
 I7Q==
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb88817920mr309330195e9.22.1795513991045; 
 Tue, 24 Nov 2026 01:53:11 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm435581505e9.2.2026.11.24.01.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 01:53:10 -0800 (PST)
Message-ID: <2fd706ef-8205-4564-bed7-527b6bae8790@baylibre.com>
Date: Tue, 24 Nov 2026 09:53:08 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 5/8] accel/rocket: add a GET_PARAM ioctl for the
 hardware version
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
 <cbb77a43deedadb6667a84bd1c57030cf1c9ce74.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <cbb77a43deedadb6667a84bd1c57030cf1c9ce74.1795478392.git.gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can tell which NPU it
> runs on. DRM_ROCKET_PARAM_HW_VERSION returns an enum
> drm_rocket_hw_version value, taken from the compatible's match data when
> the first core probes. The PC_VERSION registers cannot be used: the
> RK3568 reads 0 from them.

I also spotted that the vendor driver uses compatible-based matching for
this kind of thing.

> @@ -197,6 +224,9 @@ static int rocket_probe(struct platform_device *pdev)
>  		devres_close_group(&drm_dev->dev, rdev_group);
>  	}
>  
> +	if (hw_version != rdev->hw_version)
> +		return -EINVAL;
> +

This check can be dropped, we can assume that a DT that gives cores with
a mix of hw versions is invalid and broken.

With that change feel free  to add my Reviewed-By

