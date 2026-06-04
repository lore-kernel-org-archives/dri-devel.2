Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A8ACD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6038511A116;
	Thu,  4 Jun 2026 14:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="RLklLahu";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB2011A115
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:13:02 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5175eab3a93so5654591cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780582381; x=1781187181; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
 b=RLklLahuLTJBvtebgvKVkoPigd/xiEIA/byItSQWHN/H3MO8+/c+dDWgvg27NChQ14
 oFsfjPAuDrvxzDo1sKuRnJoYZkE8oRhXwtFxGVshtomt767A0nh5XXG8dZYtS4PHcvlY
 BBIpYigvodL6WKhzF5DM/PS5I4PulP0fMeEmYnP2slsTI6abVrkzPz1zq++Ys306s0W/
 6NtZ8W4n8HWpIli9H8Ghp4tyOxn9sazU/DYzcU73qVImIDuPxqa0P8O5dQ8d6ODwNrxC
 AiYe7nsSzyjedWAOr6VTN6dJsWTNAHGvQXEYMtJIGnRX4tIUMS/9sNAVaH+R2/VrueYZ
 17fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582381; x=1781187181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SN06MWYgnamNhN1ZWgRIcR80dI4EtU2wUgYpm//Klo=;
 b=T87XmqXap5OXMg4pr48hRNo9jFHtNlQ0HO+dS3owWheLmuo4nlCwdqvHrOf3Dsr7W1
 j/H3XuLluAr+Vu5/kZiDjAGjrpK2ItgbESrgMtXrENz5YpCi4pNhaG5DuX96B21x5/W+
 T1HjGzcncED3QpJZedoZW7CsqFp4gf4Iv6JgQf07ZIiHMcvzIyK6sfkTkC7L05Z3Otrj
 1S8xfLsq8tMKg25W7olxbiYWLIo3Pzy/nNwmuFd7kqZ9M1c+nYIZ3G4cnwOop3DCUu/2
 tl5eMyrEKOi8r80tDIL3U2Cu+FhG9ka4MmzIuZJq1x1Db6vQHkdfJ6S5LlrXn8YxN7hp
 N2/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l6+Oco8VitU5AnjeH/hDNavEHMFS6E8XrNI3qa3nPKBs2ldPS0LS7kF78pPduN30SKGC/RPH7rIA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH5vMjjIT9ytaxbx22I5oAwDxSsyCKF9MAISBroMc1SNPQs/h0
 Nml1l453P9NlLlVrH+rhlWqQap9YPaNvlteITfm9dcBQyJeK5Kj5baWygSonWw53k+g=
X-Gm-Gg: Acq92OG8CrkwrOcqnx58ESGTuI25+jyIiyyO+4H4vjGKdHxmnRmRD4TGexICEQBqfDx
 /dxW5OSlbsJ8NlauwxIO2f5vAApi9zpIt0yUlEYNvIYAVVBFUByVWxdg+NmyJJOx+v/7a7VB2C0
 0GtJOIKRK6t/tCXGryJ8asDJHHSDvReHwsXzaT+D1Npzn8Jd7iNohOgIa0sVepGbpZJJ0HuZgbz
 UuE6RHLwd5Ysgrhsa9jERRFQ+DHydK2BJ3++iQeIFfdydHEXXKLBenqoAf7+ObNXqFIGFEEGwHX
 k6XfA/7bFWQ5E1Q5tKa24h5G2/wHiGmQTyODdFjUozPDkFt5OPCSaPqNIk0nG0/OB9PJdCKQj7f
 Kg5GtQSWopzeMgNw45tqxTPrxTsNED5jD7k6qTjjf/E/zspGV5LHcEkH84RiTsAwdAmjWthRFLN
 f6I4gjMLe8FRlX1k3icqbfVBdkCsNFYk6tpTJILnRvABMbzs/vPk+PB7ts8XS4aGj5YPPlagnp7
 8hSz3LOtwPyS2Fab+1nV66J0Mw=
X-Received: by 2002:a05:622a:598c:b0:517:1465:9167 with SMTP id
 d75a77b69052e-51778696c8emr120221011cf.28.1780582380950; 
 Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775df4dd6sm52447511cf.27.2026.06.04.07.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:13:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wV8od-00000008HC1-3PHn;
 Thu, 04 Jun 2026 11:12:59 -0300
Date: Thu, 4 Jun 2026 11:12:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
 robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
 steven.price@arm.com, suravee.suthikulpanit@amd.com,
 tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
 will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 05/32] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260604141259.GW2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-6-guanghuifeng@linux.alibaba.com>
 <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c179b999-8c7f-4338-8aad-b61fd09f1329@linux.intel.com>
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

On Thu, Jun 04, 2026 at 11:30:37AM +0800, Baolu Lu wrote:
> > -static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> > -					     unsigned int level,
> > -					     struct pt_table_p *table,
> > -					     pt_level_fn_t descend_fn)
> > +struct iova_to_phys_length_data {
> > +	pt_oaddr_t phys;
> > +	size_t length;
> > +};
> > +
> > +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> > +					       void *arg, unsigned int level,
> > +					       struct pt_table_p *table,
> > +					       pt_level_fn_t descend_fn)
> >   {
> >   	struct pt_state pts = pt_init(range, level, table);
> > -	pt_oaddr_t *res = arg;
> > +	struct iova_to_phys_length_data *data = arg;
> > +	unsigned int entry_lg2sz;
> > +	size_t entry_sz;
> > +	pt_oaddr_t expected_oa;
> >   	switch (pt_load_single_entry(&pts)) {
> >   	case PT_ENTRY_EMPTY:
> > @@ -159,45 +167,77 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
> >   	case PT_ENTRY_TABLE:
> >   		return pt_descend(&pts, arg, descend_fn);
> >   	case PT_ENTRY_OA:
> > -		*res = pt_entry_oa_exact(&pts);
> > -		return 0;
> > +		break;
> >   	}
> > -	return -ENOENT;
> > +
> > +	data->phys = pt_entry_oa_exact(&pts);
> > +	entry_lg2sz = pt_entry_oa_lg2sz(&pts);
> > +	entry_sz = log2_to_int(entry_lg2sz);
> > +
> > +	/* Start with the full mapping size of the first entry */
> > +	data->length = entry_sz;
> 
> data->length doesn't account for iova offset. Is this by design? We
> should document this clearly somewhere.

That's defintaely a mistake, the phys has to be offset by the iova in all cases,
it is part of the API.

Also add kunits tests to the iommupt selftest to cover various
scenarios please.

Also this doesn't look quite right, the walk should look more like
unmap where we just walk and stop walking when we hit a physical
address discontiguity. The stop point defines the result length.

Jason
