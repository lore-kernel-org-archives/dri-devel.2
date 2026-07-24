Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B00C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9752710F4A9;
	Fri, 24 Jul 2026 22:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ImURa1NO";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B10110F4A9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:13:42 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so766838b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784931222; x=1785536022; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z2sozbBNB86MDdVFB0IAFAWmkqaPuc9KNZQmr6UjhYE=;
 b=ImURa1NOJzcCRWlvMKjuBXpFuj/WEQSfpPI/svCdilt9lr+BwZe/knnwk3/XztzBUB
 Q4fXJmgqWKiCfHvoRbLz6ZhVs80xIiZpB2xkQiYyZgxUuVWmwPF+1I334MP54oTsE3v1
 ZULnWziVt87TSprBTGw20yPrpzUE/Zc6I93yuS2cLOoWDHqAgdLqO/zRk6PJsmf1Qxo3
 bjd0HrgIxNA0NJAlH4rVSk9khNltqZ1j6I9AgiRR7xBgsZ4a+7vFe+Lf7R0ItejpzAjA
 MLTW2XNAlV7ho9Ux042noFGy22uP+57v1/si2jubMRTBSCekMiXhXwQSZWOg6SQYdTD9
 X0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784931222; x=1785536022;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z2sozbBNB86MDdVFB0IAFAWmkqaPuc9KNZQmr6UjhYE=;
 b=VMlUEBpTGQxh2J4840mJN34+4z7dc9kSfkeEvvlxDaov4LY9NaI59Idx4VPb3iO2U9
 bl3mqAlUX0WsdkxCHxJ+/m9ETKkw0CbqFbXNBprBR5TSmwhEM1LDaVRcBcrkgDIVYuMU
 /bR+gE46UPD1YrAAIzPj0ybJeh+IfQnRwFfg36RLxLJUb2HrZFnhjJG8V+hKQMuj59DI
 M9s6KgC2q9phygL6zcti6YM9eKEXc7V1bYlNr+Pk9C4tcJVb99ZEOKhvxni5Hgg5Ohve
 lKxSTUafv5hFVpMkt7dFyAsKEzsorjAr/7+cUBkf8Xb8yN4fmPC45RI9MSnvnaVa0KiU
 YFXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYYx/Z7KN/9fB+tkHPTMAZ221JSx6VPJmerxqQPgnVsbHOSyLJzxnybwiQPHPg1HtkoDkjLjbKILo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgX726jbiejtoQHMrrRLI1j2y9xZBF/s8vSm89koz0oJDhJV55
 r5e+z64+yNCTEmFRsRpDdsM93xkO7Qp49Ti9mH8tvvwtsWKKKzFpDlVm
X-Gm-Gg: AR+sD109aYVF8DDhfe8oTheJn+4SFycTHIQRGyBqvhpYMho+ggaRHYsRtwN/2Brf8Dz
 5vwgO/q/8tDsRfioAbNL7ymt5E3ELGf4RuDALFhIIpLJIBJdhKkpdmrkXV2wAjI68daNyH/cFJy
 /xToq7S1WKYBTGks5zn0+7BKJLATR8/Q8HVwxWXeG0H83m0/vGw++7kSRMwV2spuWrTr0o08Fh/
 jkAEW9qTWtGp8/WL7n7YMU2mBzuWJTBveF1ojkJj6Xw7QmUziwHDOZesglrYvubgk/vPjKU3c6u
 cWqV+hU6/AFFMvz1lMIGBuaX0SwcGrahGgelyzJEpQ0uIqvaaD50Lp/XTMK8IWKjQCQ3B2M2uRX
 FQDzZ/beblu8oBzdYwKiFqRzYa0wGvUq+rt0TDrk+HTytEof3ZYZRiyLU6xKwtm3XNe1fyupwXA
 pA4Y/WqpepHnJzhdeljYWuFXyPM5/3ZSrfXVCZcGhkL1KeguTNzrpJspvH6xOfjSsCBVzI4j4X1
 +PIfyD3G5k=
X-Received: by 2002:a05:6a00:982:b0:848:6720:6fee with SMTP id
 d2e1a72fcca58-84e59544f08mr53110b3a.40.1784931221615; 
 Fri, 24 Jul 2026 15:13:41 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:48::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5344e577sm443138b3a.58.2026.07.24.15.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 15:13:40 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:13:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amPjkerd2duU2DH4@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
 <20260724143001.5afa8631@kernel.org>
 <amPbqtxPdhs9QrVP@devvm7509.cco0.facebook.com>
 <20260724150716.07c49ad8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724150716.07c49ad8@kernel.org>
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

On Fri, Jul 24, 2026 at 03:07:16PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 14:41:47 -0700 Stanislav Fomichev wrote:
> > > > Talked to Stan and he mentioned the original idea was not necessarily
> > > > just for link down, but any test that could be considered disruptive to
> > > > other tests, with the idea to eventually introduce some scheduling
> > > > (postpone disruptive until the end).  
> > > 
> > > Perhaps have such conversations on the list? IDK what Stan has in mind.  
> > 
> > I don't have much to add so I didn't post on the list. In my mind, disruptive
> > started as "anything that can lead to a soft reset". But since the
> > sockets tend to survive these well, I do agree that your definition
> > of "link goes down" is a better fit.
> 
> My recollection was basically that the test is not safe to run over
> SSH (without tmux). Hence the link down concern. If we say soft reset
> that'd cover 95% of the tests so it's not very useful.
> 
> The existing doc and README already document the link down AFAICT.

Indeed, so I'll just test and confirm if devmem's existing
ksft_disruptive tests do or can cause link down, and submit a patch
removing for those that don't.
