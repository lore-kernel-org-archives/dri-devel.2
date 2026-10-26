Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3105606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ww00hyP4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3AA10E2D6;
	Mon, 26 Oct 2026 08:03:33 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE8810E2D6
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:03:27 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e04773687so767328f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793001806; x=1793606606; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
 b=Ww00hyP4q6cCB020hECdbIGhq3pKARobVYkwcfxjinSX3RPa59vG6sCopEVWoqEG2g
 dpbd49Y+IeqwYml43JQbYPBCxzQGxAmo+6s0BxNCBWS+rhWMzYQnAdTTQjPVTkFUn0F/
 Lozka5lzT3hwbc0PxmoyMuGZxlHaZMUyBCCzOCaKU+k5bd6YEaztmhmeu9nqz2ZrO8Fr
 gwJ2lvvHnNLP/wHGUGvs3lLMQ7QnJYtv+2gqRti1C54/bq+fTeb0FrM5a9ZH82Avy8Sm
 VebkDUzaZnusp8NEJsQvVNbWzAm7nJWuVZQG79RfWA0NZdMeHUDQsJ6XyepoXJwzazBl
 pq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793001806; x=1793606606;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
 b=ReIafO+ZUdicVqnRuJkHl2bXCMzPA2gyaDVot7TIVJmeyasCZMKitN+khRYjEcM1ab
 EGtVRxeDxpE1FN0XvRVbRPM0l1ctdiBjGbbhpWQJITMoYQ1jyGwCqKp9TACldRnBCXoJ
 dcLmSqhtiKgaesc/iaXkzHxlkoEHm0dEoa73oJT+MKZ5/W668/iLsTXQARv1+lkLrQ68
 moPjs3H4zNBNkrAUkAUABLPDOvugLo5tTYpgmADpv4ZAkZZRMRZxP2qOUvyDQaOddu6z
 DA5J4ve4vapRPj7e3Ss14rmBnMkntoGAlnT5UCFwUNSMmMlVHJYhR/S8QAb6YL2h6kPK
 Y7Ug==
X-Gm-Message-State: AFq9FYIUGLOCPsDjdIrYKm9yGceqmpZSsyjfNCJ7hrVi4lzcaMEJDDpY
 vgR0rL1++ho6rEB9tjXXapQg073ACgdc4CHcSr9+Mkq9LX6oqNvBNZa4
X-Gm-Gg: AYBFou0WcwriK4Nkv+cS1AvX2oDMZOMPTNadIZ58Ny99/qIcA2ykXyAGumAcFv0gdzi
 lplAitICRdJKBTt3bU2Z5vmUXnMc9sxThDHH0wgBx06Ug62jH1PVvSTChOW6FAWooMegsxdQU7e
 wxo0Eytkg6Bj+rSzXCygkfRQjhsor58UZf4H8LHJWiLAmwlJmIux20fPPggGgNaVwEMaQeuu/1L
 WYgyFtHZDnw7nP8wVRzYJ99EpNa/IeaBw/uLWJUaxSHQTQiEWouU4QmRJqsr1z+cyH9lCb625m5
 ULqcAh6nvaz/r8WiMGfjkZNIi17CBJkae+X7gVPT2VC8XQHsInlrrIOvS8U9wn+NVUi5/DQsP5O
 6q579jzO0PRdcDhsJhwxnWc5kDfSLvD0ld+Etxh98T6SZ51OYXy2deMJ+A4vNY1dd8FmXt/7I7/
 9HVQ/h0N1PU4QfHeBQk3hXuKZr6LyqVMkjxvE+z5sxJRJ1YsQelMFbc2Q76P67iZCEdn418Twei
 Gi12V1iFdtAmaN11HPP2GwExazlqJpA9iQBvDsv8YxUNk0iJg9TzuLPswjQFWvi9kODY5uO7etg
 q3O3oireHNHflOyH2y3UlzNG/WJ/r29+Knc7VWnvAq6emJS7N/mG5RIPEecVADzkn8OUcW/awve
 bCSTq8Us3rt0xcbsVqTDwkGzAegoa4iPkIJamhkUhZdHYsRu43fLdnF9nFmym6g==
X-Received: by 2002:a05:600c:3f12:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4a47a8dc6e6mr85645335e9.11.1793001805868; 
 Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-b1a4-1201-5c78-89f4-99d8-70d7.310.pool.telefonica.de.
 [2a02:3100:b1a4:1201:5c78:89f4:99d8:70d7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm473163315e9.1.2026.10.26.01.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:03:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
 sumit.semwal@linaro.org, jgg@nvidia.com, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, 
 treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 05/26] dma-buf: Let the exporter select mapping type at
 pin/map
Message-ID: <at8IQZ34wkHQ_5PL@gmail.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-6-apopple@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026053623.202642-6-apopple@nvidia.com>
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

On Mon, Oct 26, 2026 at 04:35:56PM +0100, Alistair Popple wrote:
> +struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> +					enum dma_data_direction direction)
> +{
> +	struct sg_table *sg_table;
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (WARN_ON(!attach || !attach->dmabuf))
> +		return ERR_PTR(-EINVAL);
> +
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	sg_table = __dma_buf_sgt_map_attachment(attach, direction);
> +	if (IS_ERR(sg_table))
> +		/* Nothing was established, so the choice may be made afresh */
> +		attach->selected = false;
> +
> +	return sg_table;
> +}

The map-failure report from Sashiko [1] reproduces with a KUnit test
against the full series:

  pin selects B -> map returns -EIO -> selected is cleared
                -> retry selects A, with the original pin still held

The exporter pin count stays at 1. Preserving selected when it was true
on entry makes the test pass. Patch 7 needs the same fix.

Could dma_buf_mapping_select() report whether it made a new selection?
Then the error path could undo only that choice, without dropping one
established by an earlier pin or map.

On the Sashiko failed-pin report:
("Because the attachment is not pinned, the exporter may migrate the
buffer elsewhere without invalidating it")

I don't think this follows from the documented contract.
select_mapping() requires the exporter to keep the recorded type
servable and invalidate before an incompatible move. That obligation
still applies if ops->pin() fails.

Is retaining the selection after a failed pin intentional? If so, this
can be added as a test documenting that alongside the map-failure
regression test.

Thanks,
Karl
