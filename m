Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D895606A33D
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i4DuLXkR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB05710E099;
	Sun, 22 Nov 2026 16:41:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA29E10E099
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795365705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LL3qYOVyI9czVO79Zu0V4wotcvHDG47da4SE8/8wYVY=;
 b=i4DuLXkRfBoKkPdQMMKa32RW1ogoVjLXgxpWAAn7VsEUXkcDcf25fZfBy5NXFNs/1EV3up
 eriU5xZLLXGAk6Bwu8V8JkwrnUS/x/VChVbc/OodWmCesLUaUBsZKS0ALFxxpUz2kzuH3e
 GgQ4gOEl5P59rDr67zLQTuVdI6kqZw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-hDOSbjNCOUugwnWw-FCu3g-1; Sun, 22 Nov 2026 16:41:43 +0000
X-MC-Unique: hDOSbjNCOUugwnWw-FCu3g-1
X-Mimecast-MFC-AGG-ID: hDOSbjNCOUugwnWw-FCu3g_1795365702
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4a7c864000eso1352019f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795365702; x=1795970502;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LL3qYOVyI9czVO79Zu0V4wotcvHDG47da4SE8/8wYVY=;
 b=etPFnUOEHt3cjXKKN59lUn42gGblLGPZMv6wVh1+izUeSamr/0scmFPhhIju76YNjQ
 S580M/7zTTmUJgg/vWgPJeq/m6zK/jNn+qYdYcqGPqGOoOwrPzNJieaGsoBkNy/T6f32
 LxI7RQWNgL5Q8Y6lGnT8VGTu2xKqta/vng3yJJUEmw12LXio675mQuXBvTtb7QQhjqMD
 8Aq0zbUGQuNGSHpDfnXXc1Ro/0vLr+Vdbi9QwZR7Ncja8wMCQFVLvEUkBJ3/wCcLb1lO
 378lCVGU0pVB+dodq3mqlbK7sOwXhRr9P73dxN/tHVf7Zts9HZZiqFZ/B6a/d4U4U3uP
 UuCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGNTfKlBFRjrYPabclkY6PtpYFmvfc0LOXyhn9NENWLJcGAFfXuuCNJX/nw2RrQToTWfjbciSA5U+Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+caJysHzOFMELo2uaGKKF0AjyokC1zFedS2ylfCb31gw87GSRR
 tfiKY7pjUZsNLwJznphoeb+/1aUS3Yg4BUBpFAPo9D+Ck4mMx8CMHKeMLCdCoHBYTeNCcyF3HiE
 AikqYUwMtCyn7tABUA+CnbwPsAK/L/bvYWbx2QG4b0bbfb/jERm24QdQtxumBRowC7XiQ
X-Gm-Gg: AZFdTZdWtd8EOgoVsc7mrc1PZAGu8AHZCCaFejIDvoLjalZIExLzalgiPwa8zBfbm8V
 01Dabkbw+cZWLBodphoIRIqgqUWEfXn7Tjsl2jDarJ0rP8JFKJNdljuiz1XvNHtV0Xm89q/Y8rC
 UUvhznicd0ffW4LvyqYwrOMx8xNaE2XKpFzdKaez5Gm/UEcoY3HhNVNEqwF9QK6BoTku1ZFMwBj
 IpGY8be5UwqvbDFvLIP2eKeBi6mEje23BtZzAB4mAHIPGgCvfR0sYGOQCoOhVIK4CuCHSLXdspz
 h5nAcXborE6vkgxEyn7+iFqH+Bng3y0NyBK79vJ0tvKLJno5119f3JNb8aN0VQJ+6EMiofDuN1M
 i3qfjyV3MV+j8xWsoYu2UA+OS8VTbNBpG4Ga5uA1egJYtdV0RkYt/TbyBItqQrVZ2WxItk1oLGw
 ARVwKT
X-Received: by 2002:a05:6000:400b:b0:4a8:dbbd:69ab with SMTP id
 ffacd0b85a97d-4abb4f58c75mr17629619f8f.27.1795365701980; 
 Sun, 22 Nov 2026 08:41:41 -0800 (PST)
X-Received: by 2002:a05:6000:400b:b0:4a8:dbbd:69ab with SMTP id
 ffacd0b85a97d-4abb4f58c75mr17629591f8f.27.1795365701633; 
 Sun, 22 Nov 2026 08:41:41 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf62f7sm18809912f8f.13.2026.11.22.08.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 08:41:41 -0800 (PST)
Message-ID: <af91d4a7-11ca-4f84-b8da-33ee1a585916@redhat.com>
Date: Sun, 22 Nov 2026 18:41:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: account for subpage offsets in device-private PMDs
To: Aveline Noir <jm5905938@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, apopple@nvidia.com, balbirs@nvidia.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org,
 jgg@nvidia.com, jgg@ziepe.ca, leon@kernel.org, leonro@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Brost <matthew.brost@intel.com>, mm-commits@vger.kernel.org,
 Patchwork <patchwork@emeril.freedesktop.org>, Shuah Khan <shuah@kernel.org>,
 SeongJae Park <sj@kernel.org>, thomas.hellstrom@linux.intel.com,
 Vlastimil Babka <vbabka@suse.cz>, ziy@nvidia.com
References: <179342234355.4.16705453209886955762@gmail.com>
 <20261121160037.1a479f3c8b4e860bc23c106d@linux-foundation.org>
 <36be0904-168d-4813-82ff-27ecced464e3@redhat.com>
 <20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org>
 <179535872126.34.4789080961796247940.b4-reply@b4>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <179535872126.34.4789080961796247940.b4-reply@b4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xqdL5SoJVDclhnCpQlcXxFM5NBuO8W0okIUg-WhX10Q_1795365702
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/22/26 16:45, Aveline Noir wrote:

> Hi Andrew,
>
> On Sun, 22 Nov 2026 01:52:46 -0800 Andrew Morton wrote:
>
>> Store the corresponding RAM backing page instead.
> This avoids the oops on the first read through the second descriptor,
> but leaves a stale backing page pointer after CPU faultback.
>
> Since the mirror XArray entries don't take a page reference, they rely
> on invalidation.  When the CPU later faults the page back to RAM,
> dmirror_interval_invalidate() skips MMU_NOTIFY_MIGRATE for the same
> mdevice, and dmirror_devmem_fault_alloc_and_copy() only clears the
> migrating descriptor's entry before the backing folio is freed.  The
> second descriptor still points to that freed backing page.
>
> Reading the same page again through the second descriptor in QEMU
> triggers a KASAN use-after-free in dmirror_do_read(), and the read
> returns the stale data instead of what the CPU wrote.

I think this is right, but a fairly artificial scenario: it needs two
descriptors open on the same test device in one test, a migration through one,
a read through the other, a CPU fault back, and then another read through
the second descriptor..

The fix lets the device private page content be read without an oops
in the context of one fd which is an improvement. 


>
> The second descriptor's entry probably needs to be invalidated before
> the backing page is freed, and it'd be nice to cover a second read
> after faultback in the selftest too.
>
> Thanks,
> Aveline Noir

--Mika

