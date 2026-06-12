Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06DCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7D910EAE4;
	Fri, 12 Jun 2026 18:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="I7EU0b2+";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6950410EAFD
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:21:35 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so10985ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781288495; x=1781893295;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+Upf3vkFcOgQTn7qEBZF1fjinQnmqMOEEdN6sxgH4g=;
 b=I7EU0b2+jkovB/7QAWczPsY0640zST2n2PWXMb919DdXDWwRT0BKU41lhYtsvPbIlk
 5kfIq0WoKW0lScaUAo5QqliUIO5wIgtLj/XsISIHRAaXuBoQKDNOqGDHAIU/vqF551hf
 ZiVf12Ya8s3jUd9yApb2rtfVKq0q8LeSCWBnl5Gt6dxbVqPggdZ+w+nYyxO2dLyxi4an
 P0vj/6RisiaxWU2QP9CRRx55aReGKC6kL7+we3MompgH/QIwP10iBx9uo9wlHtwF0vMd
 /EEzM1H6ZHNTkve4OrBDe/S8ueq4lcZIbkdfThgx9SuZQ0cuZdOrEFICrKZwPJSd0+tE
 s2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288495; x=1781893295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+Upf3vkFcOgQTn7qEBZF1fjinQnmqMOEEdN6sxgH4g=;
 b=Zjlh+6/k5Yz8qKLwBQAsZ1JOueebTbh/fEC3pWf1KJwuk2ODhfp52OHgxWqAxPGr4h
 CxTgmVjDepxZVz2bo+Ci6t+7XcVCrLREUNzDwruiHWKpqY563yhCrcXPUWHm51JoNjNt
 mLZwvfoaOlb8t0h2FjomLMoJEK5HMCuRIPp9OiVaVLlqQZVni/NlVVWbebWbYVWhiYwQ
 pwFEhTQvHCa+u+8qGxCn3NiVbTuXfY/Ystkw04HyCuML8LuhkHgChJsj+Fk/bzDHViVH
 e46i9UkmjgdtyRJR9RZHQ2wJ6yp0VLoHBDiqSRvPQ/kIGDwzkH1p4Mdymymhny9hqS/l
 E6gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3Fygi6wt44tWcYJ1nMVihfoOVJZeumUswcaLOXX9FOMkCl7dOBKrCL8YzmsSXxyoe2TxDaYnG5mg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMAj7ML3zpKrmmjEpNEArkF6Xg/baDrwXj7IOmORQCdgIYzJyh
 WMFUP4F/66RXDObUKkYK4/daly5O14z1o7YK0I+Xr5w3qW01+lx8N/VT5BOT57cpbg==
X-Gm-Gg: Acq92OHdHITw+Q7tlDcwWJdrd/ggg8LQQncab2jE/qqbXJKo6cfWzsuRovkoifepop+
 Pzegd6FqknkDErgCDjiLiAGmXvBe7whXJiSAEnoL2h237kH+LVJI6ZLVMJfJiduHkC0R8InzZFi
 AZRpShlBX6Pe14uN8WcwN+zEwR6arxHqbky48+BMXeyl0m6iswGzKQADFMCfGSX1T+yvO5YxnNU
 QOA5h7sT7U6Qv41o9er5Fr0jdLKWP7BXKjSwepKPrT3aCdaPvIEjS+wnBnREybGHjsJ6B23FoYM
 kaDDFumAm4D8VKTnRmPAAg0MXnlyC1FrhjZvZse8LCRJ9/9eKzn+f1RZoGcfk7H6es/SSduyz63
 1TE65cXg4tRMAQbdxVpJnicmTknG+DyQHOIJwQSIdjysCpCdfo1Aq0xRRtKcsxh0AKilzIdzznd
 rx9KEGbBu8iPBVWEXE+WJJ/neeSo8zGJG1VpgSddMYIhNQdU37Ux7PPvrtjqHC
X-Received: by 2002:a17:902:e743:b0:2c1:ee6e:4e4d with SMTP id
 d9443c01a7336-2c665142269mr202305ad.30.1781288494306; 
 Fri, 12 Jun 2026 11:21:34 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8663352fd4sm2677095a12.12.2026.06.12.11.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:21:33 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:21:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <aixOJs4_HHFLgGLA@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <aisa6H-a-176MXhC@google.com> <20260612113735.79518b15@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612113735.79518b15@shazbot.org>
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

On Fri, Jun 12, 2026 at 11:37:35AM -0600, Alex Williamson wrote:
> On Thu, 11 Jun 2026 20:30:32 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
> 
> > On Wed, Jun 10, 2026 at 04:43:16PM +0100, Matt Evans wrote:
> > > +	/*
> > > +	 * If we get here, the address fell outside of the span
> > > +	 * represented by the (concatenated) ranges.  Setup of a  
> > 
> > Nit: double space before "Setup" and "But" below.
> 
> Some of us old school'ers consider this proper writing style ;)

Ohh okay, I wasn't aware, I withdraw that nit then :)
and come on, I don't think you're old school! :)

Thanks,
Praan
