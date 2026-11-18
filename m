Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CD606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AvcKfCxg;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=A9Fjg43S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0270610FCF0;
	Thu, 19 Nov 2026 07:48:56 +0000 (UTC)
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com
 [148.163.139.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5735A10FFE6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:50:33 +0000 (UTC)
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIJYaan1078257
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=r7xQ
 Eq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=; b=AvcKfCxgh2FO1dLQ8zx+
 4vXb/ToMs6lkdoSyUzHR7J5mA8oTJ80Evn6C7DQAcQmCKyyCXCcVPXC1AY2BPV+D
 PrxnrOdal+rGAkWkiyrbM+AqOwlZAQ1nJhZU5MP+bzgPUyn08QXjS82Qla/J+pPH
 iCcg3Jt/KcqKZ5SUTzgJwHBANnntnyE+Pl4ScFWubQmhtGSgKuvD11x55l/MrryD
 qpYkODcKqypwoTWy8gK5UZs7YAS4kt/NOgHbNYfZYGtlH43Z2m+cRpG1dhxCVAtF
 QizC4R1HjcRvzV9dgt1KKEHn2w9dfl+PcmY3Jg7zuQba4dl/aGh85fAhkp4sBQiD
 SA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j1gfcs5vt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:50:32 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5383c05fb2fso34773831cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795031431; x=1795636231;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
 b=A9Fjg43SNTfMhZ5Hj5c6EjChITqzXkc/AUAAFjZN+2acyoSODqa9LTnNgbWqrkrckO
 oIhKebY/U7aJY5vZ8cKCNiypGAf/392064H78WTNo5fLOrRTZgYaZ51GVnj9EwfrsUTR
 Kn5WBi7rmtSVT9nZK827jrSM1K8vrzWLm+K2X+xSuUOsbwxaG+DRLHmo1taQwnvVp/Fq
 Saw2Q7cpbLVoegprpp3166D3iWSWYUKdIC2b5Tz+1NTKl6v7PiMKc4isnFS1CXfwuiGV
 crIqqCqjDrdz3ALs6tgJa2grh9crq25G6U/XisrrXasBhGIlwzrMU6Y9qFGFpoQBI2lK
 2gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795031431; x=1795636231;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
 b=otmn8CopFWt02GpnVDzkXS6h5SLfusEQESc5ZuYAlQW5YvzHWyX6NARP2yKjiTFyJX
 dDw3kDOF2gUVXngZ24q3H7M+k4L7/VBJyGQm2UlKm00QZH9FGKM67DdNHxpGrySlTVMo
 JDH+nodMkxuBsQEg/UuNs0Efrajek233ycil7Wslg+HS9NSM36bJ+w6y1XDi6Z0P1jiO
 bXZIJd8KZb2T67Y29ooWa2V5Wxw9VwCE0JVrXzzpC4JpD4OP5cwbrVGZq5mq2gZ+j8CO
 mRAHVa3CHUpzHOzr5nOHLKsMAmb9vfWZj2PDgDjgNVcugXi7JYuNbs7IxdVCyXtfs0iG
 UtnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEITebhmSkaGJi2SdRtSB1PInvJgsIkuvufPIImTYQ5VlIxSyq0u6hkto64PfYgwdj5fc3Y0sDB7FU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8mwWjCFsh98IwAObhWnug9TafmVVPzcVb8RvuDYDHp5hSza90R
 mxjzkCJIEOsfwpQz+/tcOPtxGpyzwKsCdYolqnuZnPJ+dmv7ZazPbFl0UQU+iwi/zVDZR+un37/
 1hmCZwgq+b+aDepSMh9TZnAfL4oj+nGvhaLpcgotJZy0plLKCy3zRghPuubREOX/DbQ==
X-Gm-Gg: AYBFou2eWXjL+Vlvvdr9zi26PNUMkxWdb+XTWqSrij+OqamSg+75DEpKiJQqqhHDZbT
 1LhuL3pWWyyOooxvlCtnN0j1x0EYaMHrNrGApF79sHk/vDOTYXi8nVvpMCoqQHOZCXFiTNIdvv4
 Xg2AOVSFPRi91KeKUcpBV1M6MZyf+AkgDr+QGS8IdsJpuqVJP2hI3/1wmoGRaN8SxjCP+GHNvda
 tSJ+U18qDGx4VX3NX9LveigSo/l8LeFKn/92TqOlrWVSvoBsL9iRWRPw/RhQykGso5aiRdmBpx4
 iHhAkiU83mDEvAnWr+AO4tlsRYKYKeAB5CsIzFFvjR/5A6Vrj8ZnjhUTwF3GPmVF+Us9oGjehe8
 emXbx8lpDM5c3e1CtCOGcbj5v+0vE76UG7yMDsDqqHl5ol4pMdCGl3QROZi1wn1HXlkRhaae1T6
 RAMD7ZxOL9+jG0xCNnHSPW3g==
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id
 d75a77b69052e-55d5a537991mr56617761cf.14.1795031431504; 
 Wed, 18 Nov 2026 11:50:31 -0800 (PST)
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id
 d75a77b69052e-55d5a537991mr56616931cf.14.1795031430933; 
 Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu.
 [128.59.176.14]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d66c24503sm7189751cf.20.2026.11.18.11.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Message-ID: <9a6599cc-f47a-4a27-ae8e-91c8a1a523b5@columbia.edu>
Date: Wed, 18 Nov 2026 14:50:28 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
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
 <179501525761.13527.5348420494097607881.b4-ty@b4>
 <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfXxbJMBQQmgaPG
 SHxsRjqCygnEXsjTNGH3HwLLN5PRpNisXNshrhb72rfzvdJEraZFhhHovO9RJbPGoYml83UbSZb
 Kb/44sbrb9qKQlCLCmdyNQ+lKfmlWHA0N9w3j0ZEdaZk9xOEjjEszQYiX1XPGLeGswd99FykeFT
 UqqOgv9La6+USfMTMODqCPgot9t+Gt1b7tVThm9F7Xp2vZX2D1JSNv9WTRbT/+AonBFixI3kOOn
 mBvlTW1SG7Vi3/J6HjlguDCXZl7pmtX8yL2IgwMg6J21vddyPjoG8w5lQos1SKvXPPXqfr/0QZ0
 G8i21Dno0wHGMagH3nVOZ/7CM20eRoO1NrtFUAak8M8LLYWEh41bOfiMFmH4EjndD0hcbXaJLPP
 KxVJ9ViSBmDkLyOF7CFuRZsJYyRSgnxNe9rFGQHf4jZ0q9eyXUO+EKBDYFkc5hfjRzzq11va9sq
 Y7dXbHfCCN+3ht0IDeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX9LhsawpH3l53
 ix1ItoS6AgbNkJZAbgNr43ZZJlemqFUtho79IY35SFdq8b219wQKFteiJWvqIPQ2FE7SBkjAiSr
 aWqX2JzBlRXCfdj7Yg93BbaypxFra3UAgphg6aF1CK2oiTK4uTQ9
X-Authority-Analysis: v=2.4 cv=WNnqzXsR c=1 sm=1 tr=0 ts=6afe0188 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=b7hxIIQ5yigvctP09d0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: t5fauXXNPDuWjCji9QLex4YWUqgNRUZF
X-Proofpoint-ORIG-GUID: t5fauXXNPDuWjCji9QLex4YWUqgNRUZF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 impostorscore=10 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=10 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180076
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 10:37 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 16:20, David Hildenbrand wrote:
>> On Tue, 17 Nov 2026 23:28:40 -0500, Tal Zussman wrote:
>>> This is a first batch of userfaultfd fixes, with more to come.
>>>
>>> These were found by a mix of regular old LLM review and by having an LLM
>>> write a TLA+ model of uffd interactions with PTE bits and other state
>>> and seeing what issues fell out.
>>>
>>> Most of these fix places where mm code loses uffd-wp or RWP protection
>>> while moving or migrating an entry. Userspace then either misses writes
>>> and accesses, or gets pages reported that nobody touched.
>>> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
>>> file through a private mapping.
>>>
>>> [...]
>> 
>> Applied, thanks!
>> 
>> tree: mm/core.git
>> branch: thp-7.5.misc
>> 
>> Applied patches will appear soon in mm-next, followed by linux-next.
>> 
>> Please report any outstanding bugs that were missed during review, so we
>> can either drop the patch series or decide how to fix it up.
>> 
>> It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
>> though the patches have already been applied. If possible, patch trailers
>> will be updated.
>> 
>> Note that commit hashes shown below are subject to change due to rebase,
>> trailer updates or similar. Further, this is not a guarantee that the
>> patches will go upstream. If in doubt, please check the listed branch.
>> 
>> [6/9] mm/huge_memory: build the moved huge zero PMD from the destination VMA
>>       https://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git/commit/?id=ec36bf72
> 
> 
> Aaaaaand undone. :)
> 

Thank you David!!

> -- 
> Cheers,
> 
> David
> 

