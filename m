Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E188C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E513310E669;
	Tue, 22 Sep 2026 09:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKiy+EQF";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADF510E669
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:15:34 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a98dfb8002so5501736a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790068533; x=1790673333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oVBUhiCaUFlUB01ShpltKkED8p1NxLCtsXyWQV2+EPo=;
 b=NKiy+EQF6HzuqdC96SwlhRvdcQvWqVsNQiNBxu084OGiN6at8LcB7dZCS7uat0t0lu
 k6ubZVFhxflBkl+REXPKoiBAJ2moG1cbBVjYs7xymqADKAHcItudeRmfqU/RQ7YK7nsd
 l/Ld3xvCf1JM2OOyCJSTy+YLv156tqOZnPZWvWTszla9SzsUQ25w8+FWzxze5c+lkhrZ
 b3fLVgEeZp5VAsWYDl66XvaehHKe0hLYkwQqM1fQAgmKQ1Hj/xbCnNO6XIiFCiRmk/52
 EpTLTEr9RrG0wSKHUTN9Qhpl8aEKTOmNSCzXbiVTda5gtu8bCkTWxroByoh9dCxLIiIt
 LwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790068533; x=1790673333;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oVBUhiCaUFlUB01ShpltKkED8p1NxLCtsXyWQV2+EPo=;
 b=lAkNPLzb/3tj0qvWxHcDN8UcCc+Zpl2ym5Hca328FH7kLS55r5YYzCP6VKpcEKzhP8
 c4cyvpF3JKQIMh61I//yDkCfeqxU8dpkvtqrEi0G+Brfs0yVb/uM83iinyr8/P5jFbyv
 TzOEpaQ3lz22twpfXrBVpJXwePaJaOOA+rQBQlB4d4k3PT1TORWav06BKrF+vLcWvpqO
 o5xF2z++HgZ/x8h7LW7Whzp3fvrjcijkQJE8UoM89FGjwaEWokCDyvqXWDlHwv3bHfnY
 LaQA28yPFxK2616lgVsgVSm98xry5NJqH0E6SBPpaWoKbYtyXtQDgVMSRLXpLr6gtpbq
 DQOQ==
X-Gm-Message-State: AFuF++kjKYo2FmlU1Pz0Y7o5QdPbeRRrwDn3UcUnINMrRlRYJB3iDkhk
 K28PF9Poe7or2KSI/0Y+9xOzHaFavckyVpF+W3tfoxQmxiTjyTbyZngY
X-Gm-Gg: AYBFou03Hhc1VmDEE/xDWyjln91b4/5TvVnOe/XG5Z6Tb/imi+yozdah0N76/nOtWuR
 iySmb8yHSwqSc/HhO2b3YMVLpNx0NThaAZA35+NKUga5ebCO6m3pyMMNsbMt11wW3SaJlDw0NEY
 goLehlKpTx4WbUBu5zHwCade4ghY1WLH/oZ8OAPfh3teIouv/An1Bf5gc2e1QNqQhhbNOIlx3VN
 hWQSHst0hL6yDSHuLp9jzPr+xs/7qXma1aRHP3kBG4XDQkxv2gbgGNgfGb2x0MSIwX39dfSIOow
 Xs3L//KhefrifQO/fmvRGz7Ejl8YvU0nDpUMWgqfy/h4iK6QtWFywjr/rAx7cgh+xlutP2PodCO
 viIhjriA2+4CohS6PPTOSiN4/Lz6AlB8H2UKr0vdvMlUr87xR0JpoCWvUQvcbdaXlDjZ9IZD1hQ
 S+0VC9pWd2Nf6KZaadNUbX8+CD+yAWO2HFIi3WdhRHzT5/pVEK9Gif3cokfSxup+hWdHC80HCII
 ElV+aeCrxU5GucRBSc7XDFySjphak0/eYWqGytoo7PWp1i85yd0ugW15oXGfKPzrHs/CDpfN7uC
 c+HLLs5WqRlwywpjaTW9A30bV6C/XzwJZBCxWDvlwDOKMChZ
X-Received: by 2002:a05:6402:4145:b0:6a9:9766:59ad with SMTP id
 4fb4d7f45d1cf-6aa548d810emr11873729a12.43.1790068533059; 
 Tue, 22 Sep 2026 02:15:33 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aaaae6982csm35272a12.22.2026.09.22.02.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 02:15:32 -0700 (PDT)
Message-ID: <3585660a-f15e-4b4c-903b-d7d75448ce4b@gmail.com>
Date: Tue, 22 Sep 2026 10:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/13] iov_iter: add iterator type for dmabuf maps
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <cover.1789997898.git.asml.silence@gmail.com>
 <6b78003332b57ec3a4552d7393464636793aff76.1789997898.git.asml.silence@gmail.com>
 <20260921135338.241751F000FF@smtp.kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260921135338.241751F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/21/26 14:53, sashiko-bot@kernel.org wrote:
...>> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
>> +			 struct dma_buf_io_map *map,
>> +			 loff_t off, size_t count)
>> +{
>> +	WARN_ON(direction & ~(READ | WRITE));
>> +	*i = (struct iov_iter){
>> +		.iter_type = ITER_DMABUF_MAP,
>> +		.data_source = direction,
>> +		.dmabuf_map = map,
>> +		.count = count,
>> +		.iov_offset = off,
>> +	};
>> +}
> 
> [Severity: Medium]
> Since iov_offset is initialized here to the absolute starting offset (off)
> rather than a relative zero, does this cause an issue with the tracking
> logic in iov_iter_revert()?

It is relative to the buffer. No clue why it thinks it's absolute,
but this unroll looks fine.

> In iov_iter_revert(), the unroll size is checked against i->iov_offset
> like this:
> 
> 	if (unroll <= i->iov_offset) {
> 		i->iov_offset -= unroll;
> 		return;
> 	}
> 
> Because iov_offset starts at the absolute offset rather than 0, couldn't a
> caller successfully revert an ITER_DMABUF_MAP iterator beyond its initial
> starting offset? This would bypass the BUG() safety net intended to catch
> invalid unrolls, potentially leading to an out-of-bounds DMA access if the
> reverted iterator is used again.


-- 
Pavel Begunkov

