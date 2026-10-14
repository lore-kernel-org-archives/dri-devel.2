Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1318CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FE410E038;
	Wed, 14 Oct 2026 13:03:54 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76F310E038
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:03:47 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c3762b0d45aso232597566b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791983026; x=1792587826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hySBp28FH7LStZX4dSOECc4b5G1QoNxWR9lw3M8ZY3c=;
 b=aSY7KShp+ijAcDZb/8WGmYO2M9yOHqzaJhsld+w9gbGODr9Ifog0w34YX/Do44LbEu
 xxPFAeoWoY6US4DpbI9eV/nc0ykbCmA69H2ErD9WbmhCEqeTWQ5JLhCL+5QjiOB5D3Ic
 WNmQIdaqeD9KTNsNpp7t6tCNbLNzfiUNGbApda2jyWxXjk3CGlKd191fjwMvozKFEMKa
 S7nz7z/F9l1nhY7SoSLA/feKvreU6ecWlX4k/6s1NCK5JMt8olWL7AiqxsMiCvBmR+9H
 09wv2ZAB0XwCtnkm/K5TlRAbq/sAJ0QK4lhBVnQAPMu/OXaIK1H3cKh0o+Nr4o3SoNas
 u17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791983026; x=1792587826;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hySBp28FH7LStZX4dSOECc4b5G1QoNxWR9lw3M8ZY3c=;
 b=NmQ0MAy4mzu8iH/fU6fIj8WvtlGKUEWXf8YEK5N6dbuPjTwCvxqsYbWWgkE4ivBByz
 L8DLPMFGP/r1Dx8fqFPor6GtxANVPBglrgW5K8C86S7jWE24xH08jZFLC371DtAFeTfz
 LDx01GF9d+HnbfXgJNwgD9vnK9lQmTZwLqaE86ER+kTbjO0M1WIK1gqJW/XWKdPYW8sr
 LtLiu3FzOxLHR22IY0qwbszvbVkDJYATI7P2P+166ECbAfBN1eWWvCDxD3323kpGsvwx
 wTl66xJLSy4q4ZfoJ57nCnnXir7tSrGvbRz/1HNXl4NdtKkYykopbhGLtNd/07ELzJ6m
 l4kg==
X-Gm-Message-State: AFq9FYI+vxsreaNDruBdUTs3MGOYlYR6I+3OVRsBDeIqvr52jd+XDPpV
 VGk7efi0DPQD7c5cgdG93Tt3yeKfbq2PqnNqOeHyHqoboRqy/3d8urRJ
X-Gm-Gg: AYBFou2idZYkkmrj69mbvz0YZxvcB65q7HJR+ddB4/32Ap5KIRrlPtPBJf/ROG69sj/
 PGAP9BXWAzbdYUn2cV/nKsOnDvVjr/k/BB730jkBG9yr5b/Fcplj6n10YJ7kC4q91m+UC08rNcA
 jUPXMYcASLFi/F+I6JhUV/EwSGAEdAewFSVl8LuiuUGOyvWS19u9/M9ClLYdy6Y+kpUTvFAlWq1
 S/lfNkPQQfewuA24k1E5NI/0EyQSxcudQjjhILfSBj6aqXzEXCRN4+k4tPI21Hpk+xSaJ23g5Rl
 Pu6vOo8apPh209IGng96tiN05YcrsrvSCOqiSBOt05GkpMUnfa7XxPviTPVq9kMzua/CZz80ZxC
 KLHJvAlo4mY6o+sLkRWAktxYq8lUPuWR3wqHmByvU4wP+wY7CvF9k7b2bjQwyEA67L0EXbsJQHU
 VMCZ+1f8cac+tEckA0XPIwRrZZ5ESTOdw8CnKpyRVvO8T2rsFEYR8Sn3ppLcYm4u54Y3RQWynHm
 JYUXVoFH5R7cTKLix3DnbgyrPu227CTX0Xy9A8sOSihRs2IJyyHhA4VuhhOon68Ns4ry8MVMPfT
 GSBpdQnMRX52Ia9HjweXWDzvFsh901fC8+RM9MOpH9mFYp7D
X-Received: by 2002:a17:907:3e1e:b0:c2e:411c:c617 with SMTP id
 a640c23a62f3a-c31a9a0528amr1439559166b.5.1791983025610; 
 Wed, 14 Oct 2026 06:03:45 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6ddcsm11570622f8f.52.2026.10.14.06.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 06:03:44 -0700 (PDT)
Message-ID: <8b834c2b-d8a1-4481-85e3-cbea9784f53e@gmail.com>
Date: Wed, 14 Oct 2026 14:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/13] block: introduce dma map backed bio type
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <cover.1791975048.git.asml.silence@gmail.com>
 <39b964cf7510f42755188563da63d3d5acaf2aa9.1791975048.git.asml.silence@gmail.com>
 <sashiko-outbox-171194@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <sashiko-outbox-171194@kernel.org>
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

On 10/14/26 12:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] block: type confusion in blk_rq_cur_bytes() due to bio_has_data() including REQ_DMABUF
> --
> 
> commit 338a7d60f029eb7fdd6fca422f1d54a04222c016
> Author: Pavel Begunkov <asml.silence@gmail.com>
> 
> block: introduce dma map backed bio type
> 
> This patch introduces a dma map backed bio type to support pre-mapped
> buffers without requiring a generic bio_vec. It repurposes the bi_io_vec
> space in struct bio to store a dma_buf_io_map when the REQ_DMABUF flag
> is set. It also adds specific splitting logic based on the minimum
> segment size provided by the map.
> 
> [ ... ]
> 
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 98e21b4cbf328..0cc09b975d8ff 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -233,7 +233,12 @@ struct bio {
>>   	atomic_t		__bi_remaining;
>>   
>>   	/* The actual vec list, preserved by bio_reset() */
>> -	struct bio_vec		*bi_io_vec;
>> +	union {
>> +		struct bio_vec		*bi_io_vec;
>> +		/* Driver specific dma map, valid IFF REQ_DMABUF is set */
>> +		struct dma_buf_io_map	*bi_dmabuf_map;
>> +	};
>> +
> 
> [Severity: High]
> Does this union introduce type confusion when existing block layer helpers
> check bio_has_data()?
> 
> Because REQ_DMABUF is a flag rather than an operation type, bio_has_data() in
> include/linux/bio.h will still return true for read/write requests carrying
> this flag.
> 
> When a driver partially completes a REQ_DMABUF request, blk_update_request()
> calls blk_rq_cur_bytes() in include/linux/blk-mq.h to verify the size of the
> remaining segment:

IIUC, blk-mq.c doesn't do partial updates with blk_update_request(), and
so that recalc shouldn't be reachable for nvme. Would be good to update,
but should be reasonable to do it a bit later.

> 
> include/linux/blk-mq.h:blk_rq_cur_bytes() {
>      ...
>      if (!bio_has_data(rq->bio))
>          return rq->bio->bi_iter.bi_size;
>      return bio_iovec(rq->bio).bv_len;
> }
> 
> Since bio_has_data() is true, blk_rq_cur_bytes() invokes
> bio_iovec(rq->bio).bv_len. This macro treats the bio->bi_dmabuf_map pointer
> as an array of struct bio_vec, reading bv_len from the overlapping bytes of
> the dma_buf_io_map struct.
> 
> If this garbage value is larger than the remaining blk_rq_bytes(req), it
> corrupts req->__data_len and can trigger out-of-bounds memory access or
> panics when the request resumes. Should bio_has_data() be updated to
> exclude REQ_DMABUF, or is there another way to prevent blk_rq_cur_bytes()
> from blindly dereferencing the dma map as a bio_vec?
> 

-- 
Pavel Begunkov

