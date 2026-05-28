Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D51CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A800910F5D2;
	Thu, 28 May 2026 19:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="V5m3izTx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EF110F5CB
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779996092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYcN4au38G2Xy5ZRseiMwYK5kGSwTZoITrWGoAbnKlM=;
 b=V5m3izTxAVerFRekLLMMiS10Wzwtp1UeiKf+8nTnzd4xdkE/U1Kv/R+LnIWF53xSlu3Ndf
 unFUFNaC2X9GLRqsfAOfUJtz51kCdrPMvdT/HZrtX69+QDw1QyRFEOvsZGp5kUgDhFk2Wz
 5hkUaETnJERtSDEbq41dwKgE8rs/ODY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-vvFDuYfKM425yh2pwN2Ipw-1; Thu, 28 May 2026 15:21:30 -0400
X-MC-Unique: vvFDuYfKM425yh2pwN2Ipw-1
X-Mimecast-MFC-AGG-ID: vvFDuYfKM425yh2pwN2Ipw_1779996090
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516458449d4so1584311cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996090; x=1780600890;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYcN4au38G2Xy5ZRseiMwYK5kGSwTZoITrWGoAbnKlM=;
 b=hDFCdrlwGZoyMt9nOc1IFx4lK2plJo4XJ0E5SBSMPiwAWv3ao32xNlTeoodtIp+BYK
 4GFT4EKO5YC60ZtW1PrYSREz/AtunzpUcd71ySQP9XH1T40JPlVAGl8eRcbmKoxqUj9d
 +C45qi4IO8kbPeKgOA/oOho0nV9IhKkUMKRuD3omH4ibzzehNAZvI0XjyL6c9LSXoYSm
 OW1ku+6DyzxY02lD4qGs6VO+6IZEqiYC2fh6luqsnH1zd6/w7AFNMk0Hb4MWEVavDyPx
 ixUf60ZEkBbyjdorQfDbvcO/KzxoX/Ha23GBeOk6ti+3qtu8foq1aODO/q7Cgu2tJqwX
 r7JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UW4+dFzzyp5WBB68HXwBzt3YsYqimlRhvGBuv0h1ALeuWqZn+LHbGMBJecyM/GdSvokOIMp+bMi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywtgu5KzKixqrwx0YeD3E0/2R0Y+U9XkSDXwfDD0xoXaPL8qASG
 h3C2ATYd3E6G1MBJN8n0GelS4WuX8qDGqEWi5f+h7pHkP3qjwcMpRj/5Tjepybt7j/5rXr5DFSA
 5fjCp0374xQCriz8JTLJNDRC/l4ceRLCNUAX53nAVrkuVwIuV4ItGi/z3cvG3DhhSThZE2w==
X-Gm-Gg: Acq92OGhAze+g6HDfCCljFmRS1GYAukpjb91lqko9uqUsmGHdxgqtPT7NEVlkA2QS5p
 NJ9PuQR5Pkh1DKqR+oLtM5NMi0ivoyLQuilntjC8oAEm4mEwFZ+g/3slB+SeIU6QLjyKw/Dw1U5
 48d3iqxbVN/5O8QB62qf/XDGTR9Xgt4wAx2QEz/0pgEHPXBCrEoWmpaFDkOVNirU1vow3wiYKAI
 HqaFocGWs6bA9ASwIbHFckeKzkDl946O8ZIkKwJrlUA4sHCHbR02MPmu1bj98ewgoMNcAerOW5R
 j0nwGfLXopBkWTC/LHluLlgHAnCQ1s3ULiyaFGxj8bVjHfCdjU0KCbm8g28jPK/ydYh2WrG8xiu
 R+aNxQQsgPMjW9T3IUj44TJM4CSgP
X-Received: by 2002:a05:622a:451:b0:517:282c:b894 with SMTP id
 d75a77b69052e-5172cdf83eemr1615761cf.53.1779996089892; 
 Thu, 28 May 2026 12:21:29 -0700 (PDT)
X-Received: by 2002:a05:622a:451:b0:517:282c:b894 with SMTP id
 d75a77b69052e-5172cdf83eemr1615191cf.53.1779996089434; 
 Thu, 28 May 2026 12:21:29 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706b08199sm82817831cf.29.2026.05.28.12.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 12:21:27 -0700 (PDT)
Message-ID: <3c74f55d233e1607d2b427f758ed01b2694fb704.camel@redhat.com>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
From: lyude@redhat.com
To: Timur Tabi <ttabi@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>
Cc: "airlied@redhat.com" <airlied@redhat.com>, "tzimmermann@suse.de"	
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org"	 <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org"	 <nouveau@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "maarten.lankhorst@linux.intel.com"	 <maarten.lankhorst@linux.intel.com>,
 "zenghongling@kylinos.cn"	 <zenghongling@kylinos.cn>, "bskeggs@nvidia.com"
 <bskeggs@nvidia.com>,  "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "zhongling0719@126.com"
 <zhongling0719@126.com>,  "mripard@kernel.org"	 <mripard@kernel.org>
Date: Thu, 28 May 2026 15:21:27 -0400
In-Reply-To: <6f1e4f968777c0e78b2bcd1c3ef2812b28a0ec41.camel@nvidia.com>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
 <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
 <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
 <c45c2e9096df0b407fa67ee5caee6b4641e2c8ab.camel@redhat.com>
 <6f1e4f968777c0e78b2bcd1c3ef2812b28a0ec41.camel@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_A2-biFAXIqvXtz8aCPhmy2ADEvZGoxZm9giwgA3tk_1779996090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 2026-05-28 at 19:19 +0000, Timur Tabi wrote:
> On Thu, 2026-05-28 at 15:09 -0400, lyude@redhat.com=C2=A0wrote:
> > You are right - I did actually sit down and try to run through all
> > of
> > the codepaths for all these functions, but there's clearly a number
> > that I missed and should have checked sashiko for.
>=20
> Even if you could narrow down the list to those functions that are
> 100% okay with IS_ERR, that's not
> future proof.=C2=A0 I wouldn't be surprised if there are some code paths
> where IS_ERR_OR_NULL is
> required, but then the NULL is converted to an ERR, and so the top-
> level caller will see only ERR.=20
> But what happens if there's a refactor or some other major code
> change?=C2=A0=20
>=20
> Like I implied earlier, the real problem is that Nouveau is
> inconsistent in how it returns failure.
> Sometimes it returns NULL, sometimes it returns ERR, sometimes it
> could be either.=C2=A0 So a proper fix
> is not replacing IS_ERR_OR_NULL with IS_ERR wherever we can get away
> with it today.=C2=A0 The proper fix
> is to revamp the entire code base to be consistent, and no one wants
> to do that work.


Yeah - that's a good point. I will go ahead and send the revert for the
whole series then, would you mind helping to review it?

