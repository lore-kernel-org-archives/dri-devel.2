Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97029C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0824910E8FE;
	Tue,  4 Aug 2026 08:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dZB08stG";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D61210E8FE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:39:53 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cab973140bso54130855ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785832793; x=1786437593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
 b=dZB08stG1O7FsQM8JndqSr8ZubpbAal2gZdMbRNUU52E38tRFgYHXHMI1hevK8dHdb
 MkrByoEBp9YMbQR+o6+nk5OfOfS5Y41RPED0H0j9WMKrrZn+d+vQw1qaJQHmItG8jcPR
 GEBe134wNHLWpyuneyT91CqvRwctzTkRk9JGM85vjhzFVeXKEcn2/gB+Uvocn+o90y4d
 kH2wNnqVSHH5Z+HbaE5D5hdHS09Dv2DgsQHheeMonTTeA8dVdMoC68D+nns89IE9Mznu
 LilW5VN+JSryuU/FfaM72+n1BkKguozPkZ1c0MBYQ25zo8qnXaUC4xR+mXFn0lfRrj3l
 NHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785832793; x=1786437593;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
 b=OxwXhmjCQQvxMCdk27u5tVsD4wiNiCa34Yd4jyTS6jGFaHzDYBPKXHa1QPqczyXOrN
 GIrBdCr+5/0cQaGGFQI3Ru0qZHY3PO8p5lbSfNIyrTasy5wPZ/J6Uen/6MCD9eK4VOmN
 MLMJ9qrhKXAfku/22jxYozNc8+owX0fZHt8TqJxYaHP6o2y+xQCB+xS03hUBeBalcE4s
 xX1rkx0HIC+oiXwQQ6mmB5Q5bePBlLb5XsUYxTPW3GxbIw1YT03YR127+psbOVBbzizL
 6ZsUp7kx2MSFWGGxttjpznRtyE2kXkFxVabve+eHRC091Ohi1tvxYO6R3BIReFL0ITqN
 DzJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1W9VUsvnYnTugF7vwVl7BtKecIpGWxcH0qkzuM5Xf70f3IbhOnErDB0qzC0qjdu5D0sPIom0O3Uo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykqsWe5TyQWYlz3pTBwpG0SO/sJ4NbaBUC4xvF8QtqHZKxhzqY
 +6DZGes+NEkEaY2sujiugsUfh7G/+bo5FFfXDF3KNOihVeIkhiGF6Rqw
X-Gm-Gg: AR+sD12WyDaq3NvN0epB7ae+uRyXITTbhXNoyRTgYlPll5XqK+6fEqehplzOyTQVvhy
 F+Ckotm1Gpc2Zot0Y1m7QVLKh4VH1aCpYQ2xwem3ghphXQ2GmGRAcq3k+hWFm62WmQQV1CrmzSr
 oyUdLSuXp72v7v66MGs2n7y6BpdO4H0Vywv8O4VaoSFKju7cO6cA+f9ZgyNyy0bicYaivFDtKaW
 3GAY+R8sWoK0O2G3B3EzGWrVAJ3PD7KxZitqJL0HU10HvpYqf60J5Y6UJ0q46f/9W5hz7B3VrxM
 H6nlpf6MlQl06T+DsDwkEtcVvauShd0rbBJjrufgIYQ3WGvQIy/wrBA3OtnJcJEgSXigQ0QiWIx
 Klq8B+AJ9wgsnrjz14T6AxGy9S/cozKbNXb4hcGeeWjd3dm/X4xBvCVhwTW0X+cI2zXn1H/8Qce
 BgsmC3hVou8RPzr634MzmaWsgBjdopewRUiRf2C26ULTQ5/aRpAjdRI4tagFo10jih/y/8FSmPt
 9BmUtm/dZN36Ei8/2f2YCqiPJnTRGbsplGQ0sNrA98p0q5hNmAe5GJ3nRndoZAa1++5Z4Cx3DkC
 1jCVX6Cn0XKOfj/D0f8z
X-Received: by 2002:a17:902:da81:b0:2c9:e69f:8b0f with SMTP id
 d9443c01a7336-2d0521dd6e5mr137791555ad.17.1785832792742; 
 Tue, 04 Aug 2026 01:39:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:541b]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9f93703sm3064405ad.7.2026.08.04.01.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 01:39:51 -0700 (PDT)
Message-ID: <214cf82d-742a-4753-bc86-c249366b54ed@gmail.com>
Date: Tue, 4 Aug 2026 09:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
 <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/3/26 14:20, Anuj gupta wrote:
> On Sat, Aug 1, 2026 at 9:19 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>>
>>   unsigned long iov_iter_alignment(const struct iov_iter *i)
>>   {
>> -       if (likely(iter_is_ubuf(i))) {
>> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>>                  size_t size = i->count;
>>                  if (size)
>>                          return ((unsigned long)i->ubuf + i->iov_offset) | size;
> 
> dmabuf_map shares the same union slot as ubuf, so this reads the map
> pointer as a user address. gap_alignment() below already returns 0
> correctly for dmabuf - this should too. Checked the rest of this patch
> (advance/revert/restore) - none of them dereference the union pointer
> for dmabuf, so it's isolated to this one spot. Doesn't affect the
> current series, nothing reaches this with a dmabuf iter yet.

Ah yes, that's nonsense, it should've checked iov_offset instead. Thanks

-- 
Pavel Begunkov

