Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=WlLntvbl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3D810FCF2;
	Thu, 19 Nov 2026 07:48:57 +0000 (UTC)
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com
 [148.163.135.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8380F10FDD0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:26:59 +0000 (UTC)
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIEgGfF4066146
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=y03Y
 2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=; b=nkgzzLi3h9HeG8fKyYEG
 uDh31vyXH1oYKrz4We4FN7MFzIgxKgw5bbl/1yYWvjel0KI9TY0DcA4tf8wyHfUO
 E9S3VBpfvNnGIkq1nWd7rxaJV0Lqs7OrEOCpyx0/oBVIQHwhYGWzDerPT+uUwcIw
 UNDOHrTbQpKsrdIawLbTecxwoOgThMzBSetvGLfhD1Fr+I+bJ8XjXzV/tn3a/mwj
 WnmC1oaXxkPmI1tAL5NMf/NM2XxF0DEM+oYOVbl6k3afNC9MEBBmKm7ao0MfRmEk
 9PYcQAKRmMuhT+Cw6VRw5kLAg34WlAdslNZkvKUYJ/1MhKqj8LIxnHzWfAB0TDWa
 AQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu74d5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:26:58 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-945b0154705so165675385a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795015617; x=1795620417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
 b=WlLntvblwnONcfhUxAoMG/YrAGVztFECiTcxtIRPsKR96f0ysNTpo8JfRH1FkUJXrR
 5FA6chq87kfh8uK0vn+L/4UW7WD4+2j7MoZcphn+8lE6x8tNMSPEbHUScGas6YU6m4Po
 azvgX44tvhversno90UqRQNdB31YDeFHGszpHrWwstEo4Le/fV5zoDz0qZORflySCMop
 s6pCLeFEOXDO7UEqAHlG1RRErnde50zY0ydbk5Ge0b7mBoDywQO0EJ6zy2UqDKLnm4T+
 Lpejv1M922inJtBSArsfzy2v38WRVCGpmLELG0D/BawpS7duF0wdZafdjszQs+g8H0wZ
 P8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015617; x=1795620417;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
 b=pPRyFvKbHzqKlFVTZXixWxGq8fRxYpnh68WrcMrtfDJnEvGkE5JzR8M5eMgTmYPqsa
 sUAWiq1yTzNb2Nra6o+bgFDENqQ6VVZWJVajVUtq3/eeFac19ENO631RIPitmDKHr/Jz
 /F5xEPeDcV4zVAaYcv1r61EOm5D5Jx1ZLDsXzBFAuay9Z1jrBoZb4sT36qzTpKiSH9Xy
 SLESTVgd2zdkfMEgw6lT/JnyuwyYJf4JwIHbqdaZUGqaddTNtu4wiz5H4v61ftt6lRG5
 5OoMWq7yQqLNZH3nzA6aiXmxg6tBOuj3abJlbBVlznpXY7t30/szmHKfJAJz+zM0vLfc
 5XcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFKAJV0/tCZdikXL4xNvla71WAatdPTYpQNkPIvXayM+OBcmxcFQZIXzZZ9SV9UmHR7uyc6h+7Nkcg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/strBFO3IXMq/HNQZ0CLmkW/m5ZuC+TbFF+QUk7kU7LevI7K3r
 9Ggeq+qeX2CiVuPphNbaGbIkte85VwHwJ45uATNIAW2+Q9Q06KiWDuqM4UbNL1H8hzV1aGNKvNt
 I1DAJU/x+YNc2ztaNhscfEzB6fz6XUXDRKqkouBcLQijekggw6NWMX3s6C0LBVakQdw==
X-Gm-Gg: AYBFou1pbcaFR3hpoyXBDtvjN3sIovdAKtwkJ3DqiDy09715e1ozpRGXubghC2orXhV
 aeoVX2f6ToR4xd/gTDcj/oU0oKqhh2ifGC5/EyPc8HuRLLcL9w68zzDShHGVRvv9XMJ6aRJBOda
 9aM0fhOfQ98sCH9MkazdKdRgWb/6Z7fFw/x1/Ge0upFDL9pDPnbpNgxRB5JBnF+X87QuJCbX9Sd
 IORZhTJpWiA8NMpxXLS2YdegrcNiMo0JPZsPneyW5cob3KPx1P1T8cmR9EPh4Z4EULUBQ7OjEBB
 TgBC55qOcWboD6NsN/YBA6PV+Mipt+4K9+XkPVdyAXdTQzNalrA1x/kZtY9PUtdpwbIvljanbs6
 Rlgsf4Znj2Zie2dcVT0RoMjd6q5UeH/0rkC/MG0laTZ/F/eWe8Pjnj/B5tXykckgDbU6xtdHusI
 Ctd54hB8k/xdEEmkTFbYyktQ==
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id
 af79cd13be357-949995f04bamr536126985a.59.1795015617471; 
 Wed, 18 Nov 2026 07:26:57 -0800 (PST)
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id
 af79cd13be357-949995f04bamr536117585a.59.1795015616695; 
 Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu.
 [128.59.176.14]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b72055bsm204599485a.12.2026.11.18.07.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Message-ID: <7d31ba34-8b5f-4eb2-9864-145ea80c3412@columbia.edu>
Date: Wed, 18 Nov 2026 10:26:54 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Andrei Vagin <avagin@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7htcw9DFyypU8cp_t0PVjwwKQukzUYde
X-Authority-Analysis: v=2.4 cv=RIImjIi+ c=1 sm=1 tr=0 ts=6afdc3c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 7htcw9DFyypU8cp_t0PVjwwKQukzUYde
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX0BK919fSOVbe
 oXpRpzAAgL+RA2ktxZCMN+xp7mTpQD8wD0MEnco95WS2lHXG/gvhsPxHTKPt4117XB2pk6ukH6H
 2vRka1lT2WbBuWs/nhBcQGYuvLW4NdB0D4UtloHHrFmE3q2V6TQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX60Kj3l8g+M1H
 LgKfoGjUT8fs+/Uh3FgSmZ88DAWNu2nCGnIFWyEXb5y4+yV+0p9wNmWw30PE+9KljzQaJ+S/HYn
 zHfeFKnzwPqwYOun1C2F6c1oxJXlMx2dUfkWni1Tub3bhGfMH3CCQHfRR39DyPOTh800fgyAYdA
 tzFaYIf/s2pIysNTMXPiB4cOGA2KOnnOKtALwuOAyxudnevrgk3PYLHx4oKkBgmQn1T+PBCf6ex
 OrWRfySeLGj279DPpoF+UFr5esjVl+5yuzqql71hxQGH5WdlpPI5CTcWDu3rWO+PQgLf9MlYQan
 g0pzI0BpC7XkGa9gAArRdYQn3iz8TQvq7Bv9whaYY1SwYqJJagWSza16CCNSDBnCHX+cIi5nqbP
 cUG7PV9eAbeMhVYdo8w1be5vDgUWxzllQXPTAWTkGfDJTCipZtV7ESc89QpDt4kw3Ga6YBIyasJ
 dn4leUPh/S16bNWKbKQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=10 bulkscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180061
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 05:28, Tal Zussman wrote:
...

>> Patch 6 has little user impact on its own. It is included because,
>> together with patch 7, it allows removing clear_uffd_wp_pmd().
>> 

...> 
> So, I would be picking up ...
> 
>> Tal Zussman (9):
>>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
>>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
>>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
>>       mm/migrate: warn on a writable migration entry with the uffd bit set
> 
> This
> 
>>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
>>       mm/huge_memory: build the moved huge zero PMD from the destination VMA
> 
> This
> 

So my one concern is that (as per above), the mremap patch removes 
clear_uffd_wp_pmd() after the huge_memory patch removes the other user.
Splitting them may break compilation. I would've left clear_uffd_wp_pmd()
alone but then it throws a nice ugly unused code warning :\

>>       mm/mremap: resolve uffd state when the context is dropped, not during the move
>>       mm/migrate_device: do not migrate a uffd-protected zero page
> 
> This
> 
>>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan
> 
> 
> After waiting a bit longer for more review. Andrew can take the rest.
> 
> 
> -- 
> Cheers,
> 
> David
> 

