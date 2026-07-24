Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC11C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B53310E0E5;
	Fri, 24 Jul 2026 21:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTJqbyix";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A9510E471
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:11:10 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so12071805ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784927470; x=1785532270; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bWQIrK7yeLWM4ZB3OW1av571sFujM5GYrF90hFF5FZs=;
 b=DTJqbyixK880PS4/fZK/DxWSRqMXYZm5NmlWyYVpbF9aIzt7b9tPIdfrJDiWGYcC+s
 zMGsCtunt7cnPMO1QepxDnfVStxJqMHx4ESUWTsg9luiq/oy8MTifwG8/EefE1Ivycal
 6EhmI+uXiR8EXtAjB1Da0YKrKXol7ZJzdFDFeeHnGsT5WJG6MiogMFIPVW4uvyXNiQgr
 F6HasfdNefH+J88dF2/dZXOTp9XPFiNMDq90uCyMXakKutWpr1pfARQRRisBBOaf3lte
 5aPA4Q69rVqTqCTj1+ysMm1KmLwQfkzVI+Y8mcEK3mqCpMuCDo9h45Kh5ocnSU19CfUx
 +5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784927470; x=1785532270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bWQIrK7yeLWM4ZB3OW1av571sFujM5GYrF90hFF5FZs=;
 b=s97Oczebnit534bF5bEevCIoUwQUPxSIPcLl7rPyr7pTSU4hF6hGUU9jV9Jvyq6x+Y
 F9iEZdHi3dlmxMKr8TGAvXzdxFzJjPVzWJwiVaSaayfIuburHywGRbc7q9LVDShWBldT
 z/ZQaqSy/kwdij7019hJxkpE9aW8tX/r86DpkEQwrAfKfxJTt07LSSeOmLU9Tq4RUGGp
 zIc7CzyvIFNOxqgJIWENAw22gCboSfrnuVqafFLoDKcS/2YE9Xd6d0Oh30hwGbIchqTg
 2HCHc/xbpmA9997cv7y9W9N11SbrmvAnv2mjQ7PfQlyijVi4vu8go0LXIQBCtd0oVRVE
 kUwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNMD/ngAVB/KpOnyWehAbG888zST8FV6phq8ZXnmQfh01tC1QeaO1QhRPM3B+qTZYwVLVsJxuE8R8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX9r+/HFMRrdyy+Vk8FciYGRpk5nZfAwVYTmETbcNZD5g67ADB
 GMApOMnP+MZmIPN+w88FYxiZdzUqfRuXQ93Att7zfyMrzAiNygAuCP9D
X-Gm-Gg: AR+sD123NgGFiltcVC7UpiwAwz/KER9ZNnQKaKZoQgxBxSTKuJuW0BVif5B92jvnagD
 FOiLZrqyLGk9BngSr2+z/2EddN/B3dJ+jqKcw2hSGSARGIwky0sMQvYcRurq9qVdupRJ+cRoSBS
 MZY8s8uLW+ywIcSE4KChnORmz4Gl16fmK68FQr0Oym6IabRaObhvS3x5E82cXcO1B27vnKkbK0W
 dJW/O61o04d9o5YF8bU3u0u16me/kWKKTCsvgEDmDfl5JS33nwQFHUIQRatSqikjtuagUdaQYzb
 bo0n6GDH00v1N+g1nATKXavXKx/AhAyWi8tPqVblLtNe7odwQd7SCU/CQnebSycrGS577jT7/CT
 BC+oenuuemq92KCPa4HMmCAnjOOERHj3gHy2htXubEigC8a/Ni3Do1qjuUo4ZFinmw7MUZxNlUt
 ZW3Tj0+ClWdz7KK+JZpvWrvg==
X-Received: by 2002:a17:903:1c2:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2cfd7953a96mr18549685ad.10.1784927470019; 
 Fri, 24 Jul 2026 14:11:10 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:9::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7f48f8sm242665ad.70.2026.07.24.14.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:11:09 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:11:07 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
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
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <amPU683HyCt3TJNG@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
 <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
 <20260724072419.62778bbe@kernel.org>
 <amOVWgJ3BAJ8I/4+@devvm29614.prn0.facebook.com>
 <20260724125817.4495a7d4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724125817.4495a7d4@kernel.org>
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

On Fri, Jul 24, 2026 at 12:58:17PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 09:39:54 -0700 Bobby Eshleman wrote:
> > > BTW did you add both min and max checks? Cause the only risk with using
> > > a dummy value would be that the policy will be rendered inline, and
> > > inline policy is u16 so 64k wouldn't fit. But your sample above has a
> > > max of u32_max which forces the out-of-line policy, which is what we
> > > want.  
> > 
> > Yep, u32_max:
> > 
> > +	 name: rx-page-size
> > ...
> > +        checks:
> > +          min: page-size
> > +          max: u32-max
> > 
> > Sorry, probably should have just sent the whole patch instead of
> > replying hunk-by-hunk.
> 
> Ack, LG, just double checking.
> 
> > BTW, how expressive do we want these policies? For example, would
> > absorbing the power_of_2 check into a policy be valid in the future? or
> > is that too bespoke?
> 
> Power-of-2 could be useful (it's implicitly one bit set, which is also
> potentially useful for validating one-hot flags). The trickiness is
> combining power-of-2 and the min check :S We have one validation per
> field. I was wondering if we would be better off defining the field
> as a shift instead, then we only have to check min. But I thought
> that it'd be a little unusual for uAPI and possibly maybe one day
> we will want the non-power of 2? So I figured checking min using
> the existing facilities and open coding power of two check is good
> enough for now.

SGTM.
