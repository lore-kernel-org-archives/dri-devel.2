Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD31C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F010410E23A;
	Mon, 10 Aug 2026 21:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="e3Cg1o0F";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F17510E23A
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786398175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8hpE9nsljlM6tmO4jy65/s0BrzX0SxrerfQOPk9V8zg=;
 b=e3Cg1o0Ftpay4/tWHdiUl0MRjkzqF1WeQm40o6XOoEwBrtSrFKg/G70yKUJMLxz/XB/CrO
 Mc7fFrcZ5xJDsW6OrDh+BxHF2Om48lhF06fI1qHOwyKcgUDtZ6h7U7Dk1gUO8Ao/ypr4CS
 EOi4uBeZxKLHRZgyagvPtxgpm+PK+qo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-EABCtuK0OdiFQ5Tjm57GrA-1; Mon, 10 Aug 2026 17:42:39 -0400
X-MC-Unique: EABCtuK0OdiFQ5Tjm57GrA-1
X-Mimecast-MFC-AGG-ID: EABCtuK0OdiFQ5Tjm57GrA_1786398158
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4740be00302so1991332f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398158; x=1787002958;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8hpE9nsljlM6tmO4jy65/s0BrzX0SxrerfQOPk9V8zg=;
 b=Kauoph6U86SaAOYhUPyodSf9D7ZDuZNzvSHBCAmZC5rJUWh8OMJR+Jb56uQwJdBsnW
 RteWeBjavwWwFRPspFK093giQJiSm5QZfslNRJvqfvM0YFhZMEiurbZC/mMo5vR3aePQ
 +OwcwcDHHvwc4V3tOky4Fojb6GamZ+MRDy/yFfy8xnu/DwUqZHT96LdYnfVMo4iMNMQt
 Am/0AgdTbKZCGCSm7H71walhLkFAgcoYsdjebyeD85b47qldhZH6TS6JXsCPWiCxRxpT
 H3IsJOI417fYxBI4cRXaayrgepRUm+2Ce1VDmIx13sIQNBuUFzhrpzbvceM71OmlBnOr
 QqDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RokbB6FIXhYqcO8v4uS/YloLqiAxqRZy5sn2ADBaKoABVeZR1ofeqJ+NjDK2g0CZZIniyNlBER5TJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB0lodYLaSVbhy56YrW+jUQOLl0zV77OzUlm2vB1A2ukhvuz1r
 X8iFcPcrIOmA+uQguKIFxnOMPusAWote5ST4WEXY7jgXLVzprHE1HEhzM92ZyQoCFGYrsZ+rZj+
 M34ldHsPh2FteiMd0O58f6ZXH8JfKLE8ZAw5S31A47lq62BHRolXV+qJ1ov9v7GO57MIW/A==
X-Gm-Gg: AR+sD13jlvtjKLW4hwLvBPQNNulZlt1EHHQ+eSRtGg56EXv53sTovDxITwEgRRGeVi+
 cDRYOG2HuYY+qcE9ufpsHdZ6WzaBDk2F9+g7vHFSiMzSoaz/KeKNmSXrQFQ+4/vai5VPPpRIIqK
 jh/puIZUpC54S0J3+yjO/fxBtAd6wOhqOK899f3RIYPGSAgJCKKxfh2PmFbgWbE1LNk6gD1nKWW
 BAwpjcrIcQnatwrVMoq8PewH0/Qboc+yAMflRPun5Xujw/i1DyqnizFisoFMYr9IncXkqho8F2N
 HqS8oRLrSNwonvorjAfzMLLpmZJQPB+wtTuyvX+2O3S7NijNqIekw3Y+EQJA/SjMUGdguqUU0ou
 YMce847RoaW57yORirFJd2A==
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-49961b8a027mr260735245e9.15.1786398157964; 
 Mon, 10 Aug 2026 14:42:37 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-49961b8a027mr260735045e9.15.1786398157508; 
 Mon, 10 Aug 2026 14:42:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49974170572sm17781805e9.15.2026.08.10.14.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 14:42:36 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:42:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 David Airlie <airlied@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Feng Liu <feliu@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nh-open-source@amazon.com" <nh-open-source@amazon.com>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC PATCH 00/12] virtio: support devices that own their
 virtqueue memory
Message-ID: <20260810162924-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260810021450-mutt-send-email-mst@kernel.org>
 <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
 <20260810035246-mutt-send-email-mst@kernel.org>
 <bdcec878-d627-4d0f-a97c-35e596363b20@amazon.de>
 <21714074-dc1e-4ef3-a515-6602bd19f055@amazon.de>
MIME-Version: 1.0
In-Reply-To: <21714074-dc1e-4ef3-a515-6602bd19f055@amazon.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jbmPijMMVr68O09wVAXlUKzDqtxnS_G1r2dfPnmpgoI_1786398158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Mon, Aug 10, 2026 at 07:14:09PM +0000, Graf (AWS), Alexander wrote:
> Maybe I'm missing the real point you're trying to make? :)

At least one point is not to have text like "intepret every address as
an offset" in the spec and actually make it an address.

