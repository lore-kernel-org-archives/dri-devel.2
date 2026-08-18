Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8EC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBF210ED30;
	Wed, 19 Aug 2026 06:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="w/uT14aL";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EF910EA3A
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:19:53 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 82B4B23D8B;
 Tue, 18 Aug 2026 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1787041191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sme0lWRlPwues+3nXUDbIzXVcq97z1tTJyjaUWjJXfw=;
 b=w/uT14aL41UZVnue474ddxJFYpVEu9H3ifWdHXBj28vdbAkOOMwCZwBaY48TxpLfuzvEGh
 lyNf9jmOosbpdIbqQdFwCoKVjVyKdIEEo7DCJ+Pn7kxl+NU289awLWGbspvf7cUr0PAdfV
 pH2RRbdZaZCh81jBtT1xUynlgs+xdmI=
Date: Tue, 18 Aug 2026 10:19:45 +0200
From: Wim de With <wf@dewith.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <aoQVofK2EK6Tjsw8@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
 <20260818-crazy-corgi-of-sorcery-abaa23@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-crazy-corgi-of-sorcery-abaa23@quoll>
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Tue, Aug 18, 2026 at 09:34:14AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Aug 16, 2026 at 12:57:04PM +0200, Wim de With wrote:
> > +static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
> > +{
> > +	u64 start, duration;
> > +
> 
> It seems you re-implemented one-wire interface instead of using w1. Why?
> What sort of one-wire bus/interface is this?
> 
> Best regards,
> Krzysztof
> 

It's not actually w1, it's just some non-standard protocol that the
vendor confusingly calls '1-Wire' in the datasheet, to distinguish it
from the PWM mode.

Regards,
Wim
