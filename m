Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7F0CD13DE
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 01:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A4B10E1BB;
	Fri,  1 May 2026 01:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="J+/cjfB4";
	dkim-atps=neutral
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C2D10E1BB
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 01:40:51 +0000 (UTC)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-8a5800772f3so10635956d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777599650; x=1778204450;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irmXq/3k3mxdCJm/xJdiW+dF/pEGDw/Jpb968A+Klqo=;
 b=neg+2nEhLbPPEOTeAblPGkQwA+rmvBMnRA1kB/aptGzDh5Uks151BEZBZDchWRiZPq
 saij36zIzzFEDi36VWK0RYrljbikRGPtfIFOJ5sQAUgIpgYbfq5ea0RmnhtlGghRxGfe
 euJx0vHoYkI360hSnoWiNkWMaYdKJ8SpbcZAsZSx5f+VkrG9PRZ7/urVbquvF3NaZGaa
 Gg9NZ/rL3fQ7X34f60eaq/tyqLuTIna1JBeAnJV8PSIcrgby0q2L3hlQ7nJo0drvrelz
 pyvZPN/MCGYQ8FOOGOORent7NrMzs7LSYZsS3dvmCOrsJzT2sO+jiROifAdZwQXvV30/
 HSvQ==
X-Gm-Message-State: AOJu0YwKiE8Pbr9cuN7cw7W99bds8na8bS5JMaXvS9/UwQT8vj8cJxuX
 ixqeMxGkXiNc7qUtRNBXyZRvVpRFtr08GhWtpPMgPxUgxVfzQRq8rlLuhKMZS/kOmZBVstRIc0B
 wTA8UD1SdZhh9EDrUbY+ESfHELOApsTHTzodzY3mE9CBlGSk0W5NLLIT/qQ+zkd4iT9AJP75NPl
 R9oAzNRDD4O0CR7OYHHber9lXW0xlSujT058cF2qApyXku1fnUYhXdMOCNJw77JBlWqFgqvDM9K
 QwFNFUkc2kTw8ohzsqccQkmV7Uy
X-Gm-Gg: AeBDietS6R1mQnfTBJx1zhV5Sy5iydzzodkOTDU030VVxMIi4wUiDefWYohcRGfwFT5
 MRdLdTzD4EXFN7LHs0aguhQ7EHhVmAKQKcG8pxn8NRxapNJ1HUEuY04JcL3N4k6XMi04iA5K81u
 ynjV5ecyVabJ+qikXdJlPAFpErQ+MFIW2dQmYZBWjiaBGDEprwSncv36LDRsEoEdvQitM5XbLib
 tadDA50QhONIwZ2tsJAe6yjnP6iv/l2nTk+fJGk0ny5Y9/nMRVI4W0h/tMoR1zVbov7f4Fy0Rxj
 4nz6R9ftd8V4XuP6nn4Pqv9zoNP/VRubXq1Png1Aus2+ey96bnV4DKP/sHmmOTZg8byY1nfzbnf
 a8LxQNDTwsKAyBgWTtT2JIc1g2nTJjvVs1TBwUEkItgjwDNlD4PDpOazfshF30OxSJ2KewfB+wM
 G8gyrn7dbdsq7gK4lXPR+tPtm3V80j2agFMmjaInhcTM4nCHHHX0v/lHe9RoexLkaD2lbCSYbc2
 r0=
X-Received: by 2002:a05:6214:610b:b0:8ac:7d2f:c7e0 with SMTP id
 6a1803df08f44-8b3fe7bcb23mr72799516d6.23.1777599650168; 
 Thu, 30 Apr 2026 18:40:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8b537f74ed7sm748676d6.6.2026.04.30.18.40.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2026 18:40:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so433579eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777599649; x=1778204449;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=irmXq/3k3mxdCJm/xJdiW+dF/pEGDw/Jpb968A+Klqo=;
 b=J+/cjfB4LdahwresXN6vke3S/DemCr5sasFlde0OQHKqXuVT7V2gZKIOiqairDQIUQ
 gcPR2V3DURs95Suyeft2hzm9q+pjj0+0llcKMhR3AHB4e45whVolbNr0mRy/ZUln93o9
 RklMr8TWRfnXVedl8YsObAstVbj4dGxKGDquc=
X-Received: by 2002:a05:7301:6743:b0:2ed:e12:376e with SMTP id
 5a478bee46e88-2ed3e67b97cmr2306268eec.30.1777599648877; 
 Thu, 30 Apr 2026 18:40:48 -0700 (PDT)
X-Received: by 2002:a05:7301:6743:b0:2ed:e12:376e with SMTP id
 5a478bee46e88-2ed3e67b97cmr2306256eec.30.1777599648323; 
 Thu, 30 Apr 2026 18:40:48 -0700 (PDT)
Received: from [10.211.247.102] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3bf6811fsm2440594eec.29.2026.04.30.18.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 18:40:47 -0700 (PDT)
Message-ID: <337fa6d6-464e-4d03-b41c-c0738af7d1ef@broadcom.com>
Date: Thu, 30 Apr 2026 18:43:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 ian.forbes@broadcom.com
References: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
 <20260430001913.482967-2-maaz.mombasawala@broadcom.com>
 <CABQX2QNDdFcUz=5c8AUcJu8vssGdNbrCzz2pfE8YX7gwpBVtuA@mail.gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <CABQX2QNDdFcUz=5c8AUcJu8vssGdNbrCzz2pfE8YX7gwpBVtuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 4/30/26 4:38 AM, Zack Rusin wrote:

> 
> Hmm, how is this working without the gb support? Did you test other displays?
> 
> z

Aah, I did not test those, in that case the max_mob_pages and max_mob_size parameters
being 0 cause the display mode check to fail. Removing those gets this patch and the
test kms_invalid_mode@overflow-refresh working with both sou and ldu displays.
The function vmw_stdu_connector_mode_valid() should take care of mob related checks
anyways for stdu's.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
