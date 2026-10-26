Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2941606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Khda7wlK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B4710EDC5;
	Mon, 26 Oct 2026 10:28:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B961110ED96
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793010471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bh0VMe2Rmm+7gUOYc0+0D8DAZImYcthIyBuGozvhEwo=;
 b=Khda7wlKgBX1HquEHaj8T+sZqOpGHk5kuuw7ZHI2WFLxo5xOpHzBax3m7mEopkaEw3q314
 8+/WISFV3ROJyc/1GXSleRn8TNHJ4QEBWqylZne/hPKkFpAARDFwOFXTAXMO1r19zCKgQw
 GZBr7Vc2zLOwN0Luk8M42HpXqx8Md/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-DS3o9MgKNGWfFxHxYqS4Dg-1; Mon, 26 Oct 2026 06:27:50 -0400
X-MC-Unique: DS3o9MgKNGWfFxHxYqS4Dg-1
X-Mimecast-MFC-AGG-ID: DS3o9MgKNGWfFxHxYqS4Dg_1793010469
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so2634112f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010469; x=1793615269;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bh0VMe2Rmm+7gUOYc0+0D8DAZImYcthIyBuGozvhEwo=;
 b=fZ1c6jT4SjHX1ELBJSyQOOYhizHK48/sqquLEB7ag0FGgmuy/RDVRJKPOr8n4nEQ39
 Nnchg1PsFZFEwSlvynlaoxME9d4q7YzLHSrTIBZ2OOyt58l5XURhy0YChLvlUSrwKHBL
 mDX6jtynVQgUM0vSoGIEfD+aisssYWOlqQXlA/bRgtfzZ7be0lhz8KxDew+nvihNCu+3
 rEX0qVRY0qgxvn0ufwReaUTfguHtlEGIGTL3ZeM6N+A+VySi/vmdfbFO7uTI3vuWLcbg
 +h8iwrALA3rvIVkJyYeIDVPmYIf9PX/8fNrwcZ6h3vNjsWOlPWsm+FsBS2CA+n65YTSN
 uqeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBym/m1Sy5LZ2PTV7AW5/Kue7RgsC7YSscNMM1sijkLvfYHmqrC8Y9xa9m0LrlVosnI4ACeeemWbJcU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLWiRHPEFfFZqsmo8N/a0Yml/0wNuIFtETn8pXYMZJufEam6/h
 EuhSic/PR6apE+MdqtQ+naaDTq+Z88PI0chNktoLtIfY8QnGNBDHHQvsYZthV9lfCQHoEFoLUpC
 NKZ1q65IOqbEmSBCvyrv8ClC0mW9llrkiANdJtM7eXaHYT/PfsW/wdkEq5+U2JewIjjNM9Q==
X-Gm-Gg: AYBFou0fO9l8Fb+89XI+3xYCvN9lvBX8bfvv2/VWwWVq05wMgF6rZAhTpX4H13lir4c
 duPj4wfx2ahGatrkYQ0de++F3PBNostcSf/lFi+g+EfdmsCtRoIpHfKBBpRpYedwtulT7cZ7fTZ
 hNCGfPZUTj74r+4Sarwj8wTzz74Qsq4TPx+iDmXBtxoaxti6ETEa1mKsuao7rUL4MlS3DuK8PPX
 S9CCvVtTOGYRnUA6DZXiy/HAxjUA0umAkY9CX96NiWukFn2L3B3Q9y5Ke+AQTggHpx8txS/mH24
 7PFPU+BVi1k960o7v506BMTffQA5o9vnpPqC/goqQBM47Zx1vHITgZu7WIFqIVLzsZ0=
X-Received: by 2002:a05:6000:220a:b0:48e:20ed:27f9 with SMTP id
 ffacd0b85a97d-48e3eac10b1mr11919759f8f.0.1793010468990; 
 Mon, 26 Oct 2026 03:27:48 -0700 (PDT)
X-Received: by 2002:a05:6000:220a:b0:48e:20ed:27f9 with SMTP id
 ffacd0b85a97d-48e3eac10b1mr11919670f8f.0.1793010468317; 
 Mon, 26 Oct 2026 03:27:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecde7easm15899811f8f.52.2026.10.26.03.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:27:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 06:27:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
Message-ID: <20261026062229-mutt-send-email-mst@kernel.org>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hy_mhsTMKtWnMBJLN5Q4F2pTfd6AgsZkqty9z0F7WCY_1793010469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:28AM +0530, Jayant Shekhar wrote:
> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed
> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..6c6f283733b1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
>  
>  /*
>   * Virtio Transitional IDs

virtio IDs are allocated through the virtio TC.


Reserving this spcific one as a generic VIRTIO_ID_VENDOR is now under
discussion on the virtio-comments mailing list:

https://lore.kernel.org/all/20261022091645-mutt-send-email-mst@kernel.org/

Please
- switch your driver to use that + qualcomm vendor id +
  validating the device through the DT
- do not merge this yet, before the virtio TC has reserved the
  device ID.



> -- 
> 2.43.0

