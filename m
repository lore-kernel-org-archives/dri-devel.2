Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBC0CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FCA10E1E6;
	Wed, 27 May 2026 12:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xhw0+pjN";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF6F10E1E6
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:36:37 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-902deb2412fso1323914785a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1779885396; x=1780490196; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
 b=Xhw0+pjNuzt3RLOaaXIaYrLxSmVz+NUM76FQrY9FvIDC63hDef0WX4AbWHaFm76BAC
 u8RVgrYkKdbysxKzXotOW2F1pS+nOWoCRIb3PVushv/kvwVcL2fNWVi+lTyjMMyEA7X6
 1aep/e15b32qzQY4d0JWfqZI29t3Hos+JS15sg6zkSbqlv3X0N3o4LT4YPF1by/Nh9Tb
 Z9sxqiM8XUJxPDgXN1r9MXpm91xyNy29nV1pKh8QWVF5NyfU/ZnDHgP7fLZty+nC239i
 uurPOL/lS3aHPq69rFDwFwrgcqP3OIpQT1tzmtuvcqoFYrITDXDhN8MrhtyA/3lsQSj+
 7wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779885396; x=1780490196;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
 b=YQ1stmDrOmy4d5/j//DyS02lGHhE/d9GHZxVZ0vD4BxrgdD2O7fv3kmwo1FN8T+MFf
 Z3giOyeLb1UrkwMYRE6BaqJ1VU/DAT1lh7IZAHWyWNTwh6nBDQdkFbMoX+6sdcszCCpu
 r2MzNuhjn4ep+Z5kJ3UjaXLRUoGa1X54GXXQSyui+R35AfKNJct5rFgmkLmhtzgLoYLh
 3KPcPGhWEOu6BqWI2EXrYNoYSTHxx1MnLYllVUQRDNJ1xAwI9lTNC+aycJNlKi0De/Ct
 JSp3vpVdvB71qnK0TH5AV6Zz2V+EIvjAVOrHN1A2bG4a8hrmiI8oTuY0TtilLQNNJRuK
 2yjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cz7u1bbkaS0Ak3a/dyEp+dIHWrf2DJjrZ6CJN5IKFwYz9gdU3LBpNRi/oPHjR40YzyvWqFRO5H0E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8u6KP0ZiSd2MW4kbOnYEBOO6PMek+BP9PSQzfIyCO1WSHUtc9
 sRCeEixlrVWRutqvgRfZV62eVJJ8D2dmM6OPQZz3lSzcH9EkezKlcufyqznqQmGjsJU=
X-Gm-Gg: Acq92OHrOu7izsKzgwLjZEkkJsC5tdD/E15gwdsQwnDCDLjfsRC60NBlBze2nzxigRG
 sKgkHZOhw5iXN68AtshyujwkDP9AXrgIImCsR0cvMLHRL837f8ztLvGjkmd3tIUTPwaIdvGZB53
 8dWdtyNMwCvBOBSlKD6heocq5E6wJIf5Jd1An/4oOMQJs9WdWx6tjbfoS2z1wvDHERv+IlwyDPT
 f59b+DB+pD8Tr2rkmjRrmvCXTRRB2vy8AHiDxRdYuV7csab8ldSL68gOPwS50yvomy35r1T3CU2
 9q38bRa54pJMFn+/iLXqOq9SWUG0V8xIIMu/7hZCRf31ScmT5KQyEJjS4n0ukQdX4v4MWgLfmeD
 Lrxf44qfX5LozGNjJ6LlbpM+wq+EQKIzL8gXFqzZph8Z3Hz4KEUDTkMWcVsDn4N2vHat5VaTem4
 feBmBYuvI0/JsLHnJmS9JbbSw7oBZrclrVf0xzdFHRlLEYbbV8dMIwewPxWFkfn4v65WQluGsBP
 ZBC3Q==
X-Received: by 2002:a05:620a:438a:b0:914:aaba:8d2e with SMTP id
 af79cd13be357-914b49336ddmr3211226285a.14.1779885395945; 
 Wed, 27 May 2026 05:36:35 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f8800e1dsm455621385a.34.2026.05.27.05.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wSDUw-0000000EOYw-0lyZ;
 Wed, 27 May 2026 09:36:34 -0300
Date: Wed, 27 May 2026 09:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527123634.GK2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
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

On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:

> Yeah that's a good point, I should probably rephrase the question.
> 
> I'm aware of how TPH works by adding the extra ST to the TLP.
> 
> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

TBH I've never heard Meta explain what their device is doing with
it. At least it seems to be super important to their device..

Jason
