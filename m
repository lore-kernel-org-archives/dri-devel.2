Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFA2CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F419B10F78E;
	Thu,  1 Oct 2026 22:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOgQRLCr";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D250510EE53
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:45:50 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so922822a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790894750; x=1791499550; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T4uVz4BtQRRTWyCl0InjTyP+HuCQAABpXvCRfXa1uFA=;
 b=GOgQRLCrOX3be7+7VUVGwn6kiYp5E5C2z1UuGttX/+M6DIzifKVuW4VjrGL+F7W00H
 kGmUZaHUtvpjYLa7oKiirO/JcmHGquTVSBw+fZuV6yuMohx5JbgB3HUUkJC6GYYAV3M1
 0ELM0UzXqRxrJZ+Wk6rankPGnpRvZnGJyxg5WkRRRMwE/edsDSPKDbH15wsaYSmOW7yL
 /X2KUIOkC3B5iHfeHZq/iYkoN++7jHMRGG1F7Ojpw88vGOjY22u1BA8h3EPsm6FP1spZ
 DHpEknAXZGwvIi5U8mDemXPV5kWYJbE8k+Y4WgoHBw5VPDMuMh79uI+Dq7Gn/5CEFssu
 p0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790894750; x=1791499550;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T4uVz4BtQRRTWyCl0InjTyP+HuCQAABpXvCRfXa1uFA=;
 b=Fs6CXk+V40YmVJoTMQ2sMXRzStHRCzj1cFuex6MnoqHg3d6tFWRb9WK3sra5QEbivK
 xFzMR3GMgkI8LaTprAL9Oz+10NMVS3/lMeoZPdzUqXAiIEqNpeO/pP4i/i/0BCiQGZvv
 8hO4C6B+QNj7znmqNB1qXzC6/5DBaXxCSOYzVYbXDPfwxorwWPtz0ZUaj2DaHmwWgM3a
 gKl2uXBU50UdbsbS8ubeKhLcn6uquKCcuXFplz2t4+3uJn6NmnVMutbbDe3/KRtrJkxW
 ESpUqJpj+/DyjY931c89IFJx9AQvFpNEYVcnqo3yzHrENG+seHPdls0fDw30nsvVb6qo
 VqTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgVotxk+7NMgkMqERjmbqvy0hI/dLR9ntw0BQHUHpn3/wqfkuyFjE0jeNuQe17F2eWikG3ltsXgSQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMWymfx0uWbsGUNpzgDLZMtcgMcQ/ZVzuEsOtuf8lEYciiF9bZ
 94tP73La90/Xzm6FqpXzW7/e5Mk2SoXpE1r7zICTg2upvb/PV8jjRSJS
X-Gm-Gg: AYBFou1x3UYnjbjBicXIfJ50aHl59VTQq8aWrCU5lXNYA18lDac3AawmrMeCA9WxO9n
 ODja7sGDDdAKGmPyC8VTOVsrYE16Ak1WYzIqhF1hNyknRITCMzm1pqYVGq9P+ABSe506Rd0f7v9
 u1Xspzj/Wb9+fbaxUBoZNr/divyK86xT3743UGJgNG+FG2BKx5hluUT3buABoty06UtjPNhNwXz
 zBuBXyr2eW1dC2HM2FzSNrHeY+A/IpEfZTzud4dnqXG5sG5//z+Q0CAdM9b15KZX9tCTaLf+Urx
 gTp1VcSsXNrG2PhYTS7wSWEIFFFJN3bL/+EftZvO/hU8Q6Lqab0Ue8BwSW6lHk0Y8rED/Eazv/C
 oj06LnP+JINhRgnfSiCCmdoQ/r23geeembeNdN+N4ocfqzkFh6DUs525x33ASGikwLlvLvFL6dY
 TF/HKdQr1wLY5EeyBnFJoeJquVZNfqmxoG9F996Tl26sXa/CQAL3UU1N3EovhDHSkX8kzw2R72E
 ZkMxrQ=
X-Received: by 2002:a17:90b:4b0d:b0:3a4:9fcd:6189 with SMTP id
 98e67ed59e1d1-3a6ce69ac99mr1528647a91.2.1790894750283; 
 Thu, 01 Oct 2026 15:45:50 -0700 (PDT)
Received: from marchy ([2405:3800:8e5:44e3:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6ccc92646sm1146396a91.1.2026.10.01.15.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 15:45:49 -0700 (PDT)
Date: Fri, 2 Oct 2026 06:45:47 +0800
From: Adam Azuddin <azuddinadam@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jesszhan0024@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, andersson@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Message-ID: <ar7im3iTb_UF8VxU@marchy>
References: <20261001144128.2336301-1-azuddinadam@gmail.com>
 <20261001144128.2336301-2-azuddinadam@gmail.com>
 <20261001-relight-unexposed-1a3d7dd8bfed@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-relight-unexposed-1a3d7dd8bfed@spud>
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

On Thu, Oct 01, 2026 at 07:54:19PM +0100, Conor Dooley wrote:
> On Thu, Oct 01, 2026 at 10:41:25PM +0800, Adam Azuddin wrote:
> > +description:
> > +  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
> > +  It can be connected to the controller via 8080/6800 parallel interface,
> > +  SPI or I2C. This binding describes the SPI-connected device.
> 
> This binding describes all three, or at least it should describe both
> i2c and spi in the current state. I have no idea what the parallel
> interfaces look like in dt, but if what you've got covers spi it should
> also cover i2c. Probably remove this last sentence.
> pw-bot: changes-requested

Understood, I'll drop that last sentence.

> > +        panel: display@0 {
> 
> Drop the unused panel label if there's a respin.

Will do.

Thanks for the review,
Adam
