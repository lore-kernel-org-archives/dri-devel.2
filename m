Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BDECA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6623810E4AF;
	Mon, 28 Sep 2026 12:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="hxfTj2xD";
	dkim-atps=neutral
Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com
 [74.125.231.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5CC10E4AF
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:58:56 +0000 (UTC)
Received: by mail-oo2-f42.google.com with SMTP id
 006d021491bc7-6d8709e0e13so474576eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790600335; x=1791205135; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MZr6wxL1uVtc1wSL0SfbWKw6lld4jX4MJAEXt6gdwH0=;
 b=hxfTj2xD54igtSImpx3geZF3dQHAB6aLG0JyAIMC+gYHeMY7fA8rp1ot0uV/fWPFyU
 OkEQIuhbjFQkDYXnV/E1GJj1sFq/92vUPsWSP2XV/0KmlBnnNYyphpebiaODl5TOlp/N
 veoO86Zk4BI8rh/11HCVtVlMC9SkTXisNSFd7gXu2Onz006UsDbAAttUmgsMZ31WypYr
 BRKGZqOdsi6Kot+HaNKxvoGw7E24WkfBf2VMGBbN8kA6xzHo+XNXN2VYStXJt3OwqRPS
 /uA2xNbPS3JylIw5sYZlH7WllthXuSDmPZ0QdwGi3VY6IQ064mcGmKayNhplaxFCpaYx
 tXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600335; x=1791205135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MZr6wxL1uVtc1wSL0SfbWKw6lld4jX4MJAEXt6gdwH0=;
 b=Ctqm2p4QUXTG+Gtl95QEaPS1hpBpbYQk4t/yFMW7l7lvSiGSUXlMmYlJGVbYgMSE2n
 eDlxTSb2q15dyPo93gekxtU9tDTNgn98kVYTIudO3pI2XKogk4wulQBv5mJrBJ6vU4y/
 giD/UrI17vLJxA7YgXMFsCbVSZd52hUu0G9dzMZbjmwQbjfcWKKKhNjbgiZ3i/zAdbC+
 dlle3Iqy0JSd4X4qWlsx6IjRRBBc1LtZbE5VWMg0831a8ww4Re0HWM1zcOjJ3a8DMA3b
 peaGKpUGazwLpsqb37KREAnZlJ0bULx6XZHxiTQTEeqOSQj5UJBkxiFkmEo2RAqoQjG+
 WJ0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBybX8/8XAHDjsO1sfcZPL8mNm1biO06h3gujxTbCJcnbYHnZk0lEVkTqTpkOIaLFPCBmQKtupiiPkw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKcs5ZxAP2UpiAX+ImSwAkFU1dQrsKwiu2sFGqGNg73uMSockI
 jC29GlHPEkZ2rTujLD349a/JAuR0UrESTlflwqRycw+Sng5TR1NUwAgsUW6W/TVGrsk=
X-Gm-Gg: AYBFou18v4E53Pxhn0Em8TkuAfsjEux3HSRKVoTm84skFpZrf5G2BZfCLKxsR7DDdI7
 SSz2I47vAvChj5CE+G8RxNcyS5Gqcp/r2ukyEYaCBOxjuP97tJOBQ1cGwBVfeipJNuTMqR14gV1
 Lf1vb9h0VrIwEkApczCakMS4LpjKCMn+6cIL1crB7S1M2c+sWjA08AhLJCxThjhawI3YLygpw5d
 qLZfuYPFUtAyADiIhaEL7JSyKxv/Y3O/F44a7jsnlzckPMYK1zIya1kkw2htdqZpmtIPqxrdFVn
 EJHl6NZod9B+zQnoKipkA79aAjxM7sHbaxZrBEhsQJcpW1CIjyzRjA9HddqRbKb9VQmQ7jTnKbO
 zCOv8kxzT9CymPMfHEByVSPfDwD1I6OdissddEe7X47z+M5RWfZ6v6WIvS8esb96LnzFcFfvR3E
 XhaInC2ODJdaSo44koHgcCaAtwarIeQL0dMvqd2I+YvNr0
X-Received: by 2002:a05:6820:8cb:b0:6b6:71f7:ecac with SMTP id
 006d021491bc7-6d43f9956e2mr12191525eaf.32.1790600335156; 
 Mon, 28 Sep 2026 05:58:55 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d87d9060cbsm4838117eaf.0.2026.09.28.05.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:58:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBAwX-00000006ltA-2Ds9;
 Mon, 28 Sep 2026 09:58:53 -0300
Date: Mon, 28 Sep 2026 09:58:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udmabuf: respect the device's maximum segment size
Message-ID: <20260928125853.GG163130@ziepe.ca>
References: <20260926071258.77202-1-kmehltretter@gmail.com>
 <ea7da508-131e-4146-a737-5e8778866e03@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea7da508-131e-4146-a737-5e8778866e03@amd.com>
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

On Mon, Sep 28, 2026 at 10:27:32AM +0200, Christian König wrote:

> In general I think that the sg_alloc_table_from_pages_segment()
> approach is because of the broken design of the old DMA API.

The scatterlist and the DMA API use of it is very specialized to serve
the needs of the storage stack without performance cost. Segmentation
is intended to make the sgl entries map 1:1 to HW entries so the block
layer can schedule correctly.

Nothing else needs something like this but still has to tip toe around
these rules. It makes it more complicated to map and then in some
cases you have to undo it when programming HW :\

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
