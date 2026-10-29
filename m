Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SfseDEIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF21E10E3A8;
	Thu, 29 Oct 2026 15:50:50 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD031123EE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:50:43 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso17968405e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793289042; x=1793893842; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iQbVa0edXFDC7cRO+byx8KLZb9+VOYhs4XsToamxi9I=;
 b=SfseDEItpM3uiU6RQ82pSilWu0QCFU0B1F7wn+PPX1dAvgxRYELRPjErfoCraTouAg
 AieFP3ZQLduPPk19vFxR8ewGv8n92W4cqZrJRQT+CfAx1BDo7ZhJK5xHZbh/eOK8Elgq
 tLsza62ux7xi/xBqtNJZZmqYaN2TNsfjjZ7IX/9PQMViN3KnrWfTUoyDwv3A+BWtezE5
 4ppCkfvNtr9sqCXw0mJURUtcrZX14oCRVtKJoxNZ/QIyW3q3hFgWSTavxHzmeBmXnQo4
 1D8qDqFQJ3noO7r1Kl8ywKaZ3RH5SGuFInJQn3MtGneW3NMJsHXzC4FmKARvurZwxnvG
 +1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793289042; x=1793893842;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iQbVa0edXFDC7cRO+byx8KLZb9+VOYhs4XsToamxi9I=;
 b=m+xcMhbzK+JYuXFgvNnAIRpxTMIduHg5ysD1urxzU000iEw1RRsdGQpa1ryVUd8paw
 nZemsl1HxDEReJ6AzULNjxphuUa6wxNPLZaCtfS+SumModzNlCxIKXKVsnA3s9niXeJQ
 LCb55+KHbF9UY3Qm7QOraJVpBEs0XobeX91AydgBEWD3qa9HUPSRMrnaQrr9QP6gOY6L
 R57UzbXk8EE74yddUUHqxMr2lj83w/TdW82haJ3Gt4UZ3axd0Eu0fSOfIIcZqCaiqAHy
 ++ZB6J2D/gDlmYXal2ETWkvefotpcJUtPpWJux9QEG7sL9UEmpGo1CuCSwz0itX2pr8A
 BJXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrN7JCRP5N9FuLaI30Uckm3k0Iq/kXUqobz9wFoLqzJ4CpNkE3RMCl+tGcsJ+HZrE38t8ZbClyJtY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKSviI8oCGqQOPB7XaFgY1TuIbJFFTiWkyKLmXigNRTEOUpWQVH
 3Z9cClG8wX0IAqUtWNmDSbwBU9ctK3BHF9vzSFMvniVs8I3H0WcYIgi54dDKjiYo
X-Gm-Gg: AYBFou2vKTD7eg8vt7AbtZdJVP6kQ9Mx3ABATtfAvit5nCMBla+IexpZA12cH5jjAuO
 qHIxj6/zJvkDo0qIgDlRE8sBHpFn39oCwHX7Ve3IBav1y4PCTH0OLODzsCn3P4kOu4ovBQ1XiGr
 Ku/4iCJwcRP0Z4kJqdHOPPECwfVu2o/WM/mgKznmEbprxBOAakdLAYT88BIFoCUEbYGanC7L2FA
 d+6i5NTQfy0fFmulk7MsXjw64cMLNKlGHOm+EgELiuEZ87DBidl8yE+adg37CGe5lWJzKDamP7T
 SjjSa5yb0oelmG+rgSUzSUKXdhY/qMv8Dq9QOe6bSrgj+AeQ3IO6GUFglJa8+mbuaK9FNe4s0GZ
 Bq4znIOetaTeJHE1fHpx4PHLUr4iw/e0wUZMC1f7s2clv+ioqLpTD9oQU12tSNHIyqm2bTALJEX
 L8yDlfq+elqu5pQPOX248hfQbg5bWe8tZ+JOMywcblgstn/rzGMsyoSDWo10m73R0+85FQc6LLc
 eyyYqfVANpbZMfDpuPnnZ2L7MFFtxQ8On/ZiSSMoCibQRDAnlYqeDBp2wvxtBHyAAkM8q5cBaKn
 W182F8qO36DvEGfwZeoT1dBaxLk6bZmZ59GeNi5Y9iSCxN/JBlr92rEHsSnyvT5MuSTkI+o8E76
 wFEUjZA/1vOShQdRgVCNAGOjaaG/kvshT3Vf1pc+uF3XhSCaoIK1SeTs=
X-Received: by 2002:a05:600c:c106:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4a9674e80c8mr103774075e9.31.1793289041762; 
 Thu, 29 Oct 2026 08:50:41 -0700 (PDT)
Received: from ernest.hoecke-nb
 (static-2a02-1368-6200-2fbc-d3e8-e0a5-7e8a-a15c.cust.swissbackbone.net.
 [2a02:1368:6200:2fbc:d3e8:e0a5:7e8a:a15c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm42419806f8f.44.2026.10.29.08.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:50:40 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:50:39 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, tessolveupstream@gmail.com, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, marex@denx.de, valentin@compulab.co.il, 
 philippe.schenker@toradex.com, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Message-ID: <sqilixoei4yw4z52r52vbwfggyjnhdzz62vz3vshrx6wbppa2v@izyujkfcrb6q>
References: <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
 <3hfae2i2i2toxbo7hg2if6pztaswgnfj65xfm2c4ofljc6jhua@slaqoewn4mxq>
 <DLATMIFKDMHV.24XNMCRI2ZKBI@bootlin.com>
 <20261024095405.GA5692@francesco-nb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024095405.GA5692@francesco-nb>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,
Hi Luca,

On Sat, Oct 24, 2026 at 11:54:05AM +0200, Francesco Dolcini wrote:
> Hello Luca, Ernest,
> 
> On Wed, Sep 09, 2026 at 03:30:53PM +0200, Luca Ceresoli wrote:
> > On Fri Sep 4, 2026 at 2:02 PM CEST, Ernest Van Hoecke wrote:
> > >> > Also, from our testing, when using:
> > >> >
> > >> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> > >> >           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> > >> >
> > >> > we are not able to get display output.
> > >>
> > >> This is the case for the panel I worked on as well. In the practice we both
> > >> observe that non-burst mode is what fixes the panel, but there is no clear
> > >> explanation of the reason in the docs (that's what I hope to discover from
> > >> TI).
> > >>
> > > I am testing a DSI panel on our Verdin iMX8MP module, and noticed that
> > > this caused a regression.
> 
> [...]
> 
> > > I think we'll need to either revert this and later apply both together
> > > when ready, or apply the second patch now as well. Right now, it broke
> > > the DSI panel behind a TI sn65dsi83 bridge on v7.3-rc1.
> > 
> > Reverting is surely the last resort. If you can answer the above questions
> > it would be good, maybe we find out reverting is not necessary, and worst
> > case we'll revert with better understanding on what went wrong, and maybe
> > come up with a new fix that doesn't regress.
> 
> What's the status of this regression?
> 
> Francesco
> 

I still need to test and look into this, that will happen either in
December as I'm off in November, or by someone else in the team. Sorry
for the delay.

Kind regards,
Ernest
 
