Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B5EC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BB510EDF6;
	Tue, 22 Sep 2026 17:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gopvVuib";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7936910E740
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 17:19:54 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-3a02902dce2so107200a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790097594; x=1790702394; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
 b=gopvVuib/DUYnp9/HnNEYrWan5gZ8XT9UiMqBBUn3QcaxPYxTPKv2dyRoueNJfcBis
 LQ8zCVbw2wAa037/0iqV8WStQr/SOqCWaVIzrCfF022j0+7oMdAH+MSmazAfRY2aEHaf
 18JfKPu7TlaOuyYtussKqk1X1LVy8WiGcSQxtxCKKinV+ZJJnKNv5tIfA5JxmymXWyag
 0D0629z5fp5mmc7Rya7L6R7Ck8DqjWoeg4ShUEV16JaoWfHFEjZ1FbmKlwA/D5QlY0d2
 AJlV+6ZaF2MYfFRUWc5qr2nYZKKqgcjfR3jN1lLjK3IHN+bu9Kz/6uD1gDgoEZNtiUbJ
 uvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097594; x=1790702394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCRq4hnTSVTOASY3u8FUiAUCCMw+X4n90vfRzUKE6C0=;
 b=mOG1K3d1K9i2p8ZjQL4WBvatJT4bPZ7Np6JZU8xu8vAcYQQFls44+tV6xw2EO5EvPr
 FR/wAEbjn3OXufCrMtXbDs0e9VudZo+6XZwI9uTIbmXlgmrtPod68cvDdHOGzSEzs6Yl
 pfl4aIk5eiu6ZmLR6UrJf7nMPh4GvsglHmCusRuN1ACxeJRgEyM21NO7luFL6+hrFVO8
 hW/AOzEfZUe6RADqeSDFlE4RpBdIzIew+zQNkxtKe/oUDce7CyOhP0CFnYQLWX7IpUuJ
 f6TiwvL2xOINtuK1Rlf2gFXaFDcw+GyqFIDQjsuZ6NvLfit1zPPG8zHcW2YM+V6gFi6m
 kEog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGnfiUCAlqFlUqJzoepANcTVQZjiH8Y15/qAzJqmL3duepjVUCYlyx7abpVRY18ELrxPg6p2HPRLM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZ4s89IUJMGVUbOr9GGJJduGDRyD2V/TTSf3ge0L68uOMScWjp
 ahny2sQLwiRnPKbEErgDrk8CTWDs+Pn+FgYmdG3/KB7ke2uHWLzioyhgLhw0Jdh9
X-Gm-Gg: AYBFou1RCMs+U5VZar2sJS7zgkVst5GPV5laTrAYwFS+zJtHT7jUdBHHt8T973DiuYu
 9/nbtO6ggNM4mpLWlzqZ4PkVo3hrJ2JK8cmM2tkoa+AIe89qFjQLEio9dbzwvme5v9pSBmWh6qj
 /16RZvWY2rU3YTgLM2zP9vXQAwWyzqIRb4GS+h15g2UyO08WsaOCewVwHIKvMfPCS65mSR4BikO
 Psa+sNbNDGPglq4keIrJWr3vZTdWrCIIcWcszanwcvwcPoGcTzI5BJd0cWpgqdLLRnqmW8hwMmf
 MQlLsvJs/P0zMjzliOWx59fmI/eUjpU/VTkJBDU0i9rff+caomSO0+C/86TxQNqQIITsvYn1wph
 tdYjoHaD3HpmPAKL6qc/hq7oTQQSARgDsMNiDDto8cmK/0DHTen4Jwe7Hzip8WyO7PFKm8HLr9o
 XGjOv3E/Ta9GbpCvchlxVxI0eHUTNtcOzjVXRrd3dg0j8xhDiWYqsvMFiQb6fhD3imzPPzoHwTX
 uX6KSct/5AWYg==
X-Received: by 2002:a17:90b:2b4c:b0:39e:1ff0:331b with SMTP id
 98e67ed59e1d1-3a07e4f7b61mr128059a91.2.1790097593735; 
 Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddaf4f5sm336767a91.4.2026.09.22.10.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:19:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:19:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with __stringify()
Message-ID: <940e0763-9de3-4d55-90cc-8289d5525b17@roeck-us.net>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
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

On Tue, Sep 22, 2026 at 03:32:21PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to watchdog-next.

Thanks,
Guenter
