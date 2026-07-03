Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49E1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE78310E4B9;
	Fri,  3 Jul 2026 00:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XetlJrW0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7A710E4B9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 00:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33A086008A;
 Fri,  3 Jul 2026 00:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194C1F00A3A;
 Fri,  3 Jul 2026 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783040260;
 bh=dgOSzXi3H3wJeZW1ociIAvvOzPFpS+FmJNkakpTdycU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XetlJrW020pJ2/NodgckE91pFr2iY+JQaacOLVnDqnPf4tkEAprlnkwak07XsOePW
 GvKmsk6KS9YdrF0BoQkJZHJjCgzCeHre65sz0qfKZGuCx5IluCAsrGQ6bsy2hgr7yF
 hc8u4QhVJcG5JD3ZKHG52W1KqvVFm7Rpjb68FSpLd+aqc5upA0AZVKd50bYYqiRK2G
 vM0MhPb/6ACRq7DO3mT6kRpQ7hUR1B4iz4z7sjgCtIPAJV8tRL1058fJOBf684uxRA
 J3s8i5JyuMmFUU1NHFCEI6QZrTZ3MQcoVX3xYV36HXV8dFPEG08Hoy0J6fns67rtcM
 TQ+OFVo9iheLQ==
Date: Fri, 3 Jul 2026 01:57:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <20260703015735.1403d1de@jic23-huawei>
In-Reply-To: <20260617080031.99156-6-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-6-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Jun 2026 11:00:22 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> are used only in lm3533_als_setup(). Incorporate their code into
> lm3533_als_setup() directly to simplify driver readability.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
LGTM
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
