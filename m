Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCFAC98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF3010FA98;
	Fri, 25 Sep 2026 13:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fOKfPt2k";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D1010FAB1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790342544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mfp85Na3VIvxFepbe+2FVNLR998tfGijRwpOnXjXS0E=;
 b=fOKfPt2k/qkngRrNihgEPzV+PiFb3us9Y3/uhFjMZ1TdRd3BmG+M0oag/GpTFq7R6JyCkM
 nY45gWV1lPCbKIBOvDkm2/XSodcCTqlJLPz4K7ZHGOcU2wezsvP/3R90SlndcwzSHfwzSH
 tWy7KSCpXER0hwV0VpWlVtHWNBbQw6c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-XfC5DskFPhqA6Efm3Ft7ow-1; Fri, 25 Sep 2026 09:22:23 -0400
X-MC-Unique: XfC5DskFPhqA6Efm3Ft7ow-1
X-Mimecast-MFC-AGG-ID: XfC5DskFPhqA6Efm3Ft7ow_1790342542
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b5e279489dso596254e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 06:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790342541; x=1790947341;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mfp85Na3VIvxFepbe+2FVNLR998tfGijRwpOnXjXS0E=;
 b=UR+UL/BmmHi1nDE3tKESa96llZXo03ganM8tD7yJPoMiDc/D3T6R1H8emJKb/LFnES
 j5/HRduYDYDkkI2JIMr4pXs6Wu4MOaTrKHC9FEQkzAVLSNHO1FECy7Euyn1EJ8eMiS/7
 U9gS2bzgn6EAmr0gbZGEWN6ILNu5OzHBf5hL2ahSF7Z3zpESRwzQOzn+PtSsmHeJemuS
 3DRH/dZzwWAB9tU2soBe23cTXQxKoCgEa/6g4IEpScFLddlz5YPpZ1lnJ3UNOVjGQS+e
 x6pSDvFBtvGlNa4e2Dcg5lmdmtI86cF/UZa8postg1KktRG9TUL9KPXyRx636EFr7tmw
 CIiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNvyrIPBe6qfwo4tXybPpg9n0ge82do7ihE+kf/dKYW9xMaE6Ntfe5a8F0nEktn9D5S7pK6t3iayg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lYUEJQ7etnjxtjnB3Sa/kVtibXtuOpkfd7hnmiw47INrzOfIu+
 T054StucWX2nRE3OSlTIOg5jpUn0pGzSGjg/VTWNkxb9qd2WLQFWicWZU+uS9GxmqfT8Y0ylP7b
 bMxu/m3jiFN7Kxu46CQJcvO0Gv3svLP3uZyvFAXSXMOUhR+hSBKM5s4abmgIoDVaqP6aQ
X-Gm-Gg: AYBFou1TFg8C2kQzIcVbv6tsi2R6rCvh4w2WBNl9Q6qjvfSL5Vu8f+8luXG8EpGVhCI
 3SQrmrjvPCKQs+/Xsn53dqtW9mqX3SkBM36LW5dx8nfJS4YGmDGuQunKPY65EyIJBXVS/XPeGXp
 D1CCR3O/He7KC3Sv/zWPN9HECGu3YSBYCEC0D632Zsits/I5zYU1FRZ8n0WWdYEg1OWJ9G7bLFl
 NTC1QTg2cM2DfJ3hBHCEVCGVDvZ3DPiE7JjDBWC/7xcJVoPl7uq9yI4fLyxkdGQ5IMz1qBHr2Wb
 kK2F4+ZCi4vdqEJY6P/Jc1vLykOxn4QyxZGw+QH+sBIOI1e52Sf0fsvky4nBEuTh0toShRAhPrE
 c32uLFRfZPevlo8bJdUWvKBJjs0gSSSw=
X-Received: by 2002:a05:6512:3e10:b0:5b1:121e:56c2 with SMTP id
 2adb3069b0e04-5b8e6b36729mr733454e87.0.1790342541319; 
 Fri, 25 Sep 2026 06:22:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3e10:b0:5b1:121e:56c2 with SMTP id
 2adb3069b0e04-5b8e6b36729mr733437e87.0.1790342540724; 
 Fri, 25 Sep 2026 06:22:20 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c2ea5d2sm5510451fa.18.2026.09.25.06.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 06:22:18 -0700 (PDT)
Message-ID: <f7cc0ac3-729e-435e-9062-3317d0a6517b@redhat.com>
Date: Fri, 25 Sep 2026 16:22:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] migrate on fault for device pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <arY5zKsLuf7f_EYw@infradead.org>
 <65c5c412-56a7-46a9-b22b-22077a8e9727@redhat.com>
 <20260925124737.GL9354@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20260925124737.GL9354@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LmLly3vYX8RH6TMAU2y9x68uyHvuA5lOD5DCIjR7CGM_1790342542
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On 9/25/26 15:47, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2026 at 01:23:52PM +0300, Mika Penttilä wrote:
>> On 9/25/26 12:07, Christoph Hellwig wrote:
>>> Who is going to use this? The series seems to lack an actual user
>>> for it. 
>> Two users: For one, existing migrate_vma_setup() callers, unchanged.
>> The series reworks migrate_vma_setup() to collect via
>> hmm_range_fault() internally (it sets HMM_PFN_REQ_MIGRATE and calls
>> migrate_hmm_range_setup(), mm/migrate_device.c). So every in-tree
>> migrate_vma consumer — nouveau, amdgpu/amdkfd, drm/xe via
>> drm_pagemap, lib/test_hmm — runs on the new path. 
> So split the series so you don't add unused interfaces for now? Jason

I think we get the other for "free", migrate_vma_setup() ->
hmm_range_fault() is the now used. But if wanted you can drive the
migration initially from  hmm_range_fault()  also from fault handler. If
don't want that then it's removing 
EXPORT_SYMBOL(migrate_hmm_range_setup);

--Mika


