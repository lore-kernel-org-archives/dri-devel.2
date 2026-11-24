Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=dDI9CewA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E438510E186;
	Tue, 24 Nov 2026 19:37:26 +0000 (UTC)
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com
 [148.163.139.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C51010E186
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:37:15 +0000 (UTC)
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOJYTcF3474072
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=OMjg
 nMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=; b=ArQqb01Alvqy+ezQ3O+b
 wFGaLKLkRPslDfTTnR/1n3YHEnzFvpSAXsSLtAema3OMBGvQTr8MjsfnQdizF1DR
 Y35c9K1YbdbrokVp6lJBFIYVrUHqLLS3WYYBtEDDKg/6m1bODWncA+LZwiNP1MH8
 Z3bx2LUxG6sfpmxDdUI+/kyZI7guQlRgIUWOBYQ6reZ57nqjYw3JFREOmJXGhsy0
 5UyyJqrfI8VjX2MlX1xqtk46jQix4pqRNZv16i1aL2PIz3aAJytU8fQlN33iF7Uo
 xruvXaD2EFNKvtzNiOaeLj7AUiUNlwagsbKMIv+l5TRcoparlTssaELubPi31AEG
 DQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5dqcj8r1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:37:14 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536778a8137so87210701cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795549034; x=1796153834;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
 b=dDI9CewADpfltMyOctEQPXef6qPnURtuo0OcT6SbxH3+FlE/qJUYzqIk1vx6CB7hPF
 m6heUBxPsiywc1A4mOJnWGJwRRXEqaqBogcevklS8h/hpO3VLwG7q3GE941ZMYkFoo9i
 XahTHRfSjvaBgI6h8sX5v34XHSjDDnj0zvhERWBJ0HHcphspAyPUoVsNvhy9yTd6ETuN
 RM7j+08t2tuHma+g4qDjVAmbDUS1peebrC/jMUMIUPcW8QYTTw2zc8RAMZREcvdTfTd5
 IuyZ8DVXX3Zm6RdVgJIsaAuaftrJbgRWsBdsmotXmbtpQZc14BWHCN7sfRk56hHDtw2E
 w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549034; x=1796153834;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
 b=rklj89hS5fYAxtgXSDKCqSEDwxp89LxTS2syWsGkbdiXH94OroAHDUeBpy7nffu8sw
 sU7SmquIttLQhnzaGbcpvsfdd+eQKgk6pUHwpdK8EgbHeUtGBy7yhvsvWa5+YDbYTenb
 JHbigwCDRj+63T4Glg7TSwxQc/39uS/+kP+4SKfXDqfvBdoB8JeCZUPS1cWY9waivGEn
 HKeFf8AY1RL6XLcqmeh4W20Iu4kwrr/LOhtZbEgiJAGblcNSd5bbxQEpq0XEnDxHJqHp
 47g7n/17qU+m89/XEmqACCwA8k4AATc+2NlOXiLE7i9ZhQRy90rmuObSUP+E5Yn218X6
 CChA==
X-Forwarded-Encrypted: i=1;
 AL+hErG3vRdrWIYFuAuoI8VWNCaHWrHO2DNXtKw6f3Odjo5hYvkI4RBGBnBREpxESCXzQL8rFyFh9PBbEjM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Ei5xi5NSYWRxVIbsJmjvCZeXNA3jzAOKYqOhGZzwa61VZSTW3
 +rLHQz1HRozGQHMvKogq6o6Bcx939wpLYscTMGg4LUq0w0aAgjEPU1SPIvUs11YfoPXx+DE8Usy
 UUkYl1SmKe+3QnzXTokYYJaYQTkM/ugkZ3pXOHyeDqdMEHOLNWsxZF8Z5PoA1Ryh//w==
X-Gm-Gg: AZFdTZfkNtcJtb3XWJGcz3d+IU/fDStn5rnD5EHDQbs2IbI7r/VysQ9GYVNuAZeWxOZ
 gBXOaQohSDYOPvZNJoa85tenxn/q/Y4oREyHfskFu+aNkIR/8Zbjz4rlFZSrQrZMrgs8z6bo8K3
 X75412bn6jzmEetGZzEx+1n4zLQGijYWABEsGUr1r5O1G3TSAL7u6hnJomCTmOVhHhUNQ3Gi35i
 9MdRse3ectX3flU2TptCnvzzahrYtcbw/gcYV30hJeg3ZfRcVLVDctnVLEnIBcpZRb4+bLgv2za
 HLumjwCQnW0UPE9Tz/G1kriSeDq/TozNBn17Ac2qL37tcDsPlBI2vvi9uZ7gTJjkC0zQ+L3Ezxy
 Bvr2LTn27RL/ZUiBlGZ01xh73lOx4JRx1s+wtTgaXGHKjpjlDcy0QdAOOJDG+20v0hg==
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr288718521cf.49.1795549033840; 
 Tue, 24 Nov 2026 11:37:13 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr288717631cf.49.1795549033344; 
 Tue, 24 Nov 2026 11:37:13 -0800 (PST)
Received: from [10.206.101.158] ([129.236.231.128])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9213515f467sm140631006d6.41.2026.11.24.11.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:37:12 -0800 (PST)
Message-ID: <3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
Date: Tue, 24 Nov 2026 14:37:11 -0500
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
X-Authority-Analysis: v=2.4 cv=Na9zRGD4 c=1 sm=1 tr=0 ts=6b05e76a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX49VsoG/eq0Ye
 6yvCdhdD9l1K3kaGVYSokjqleD05IQnifWqrmh3lOoiRTsxeLOK5fpr1v/PmcYVczGNEFMrjTFJ
 D7PGCDEcKo6wSqdaU8APiqBge3j+TDQtiOwTW2km9c+B/P24C4Co
X-Proofpoint-ORIG-GUID: H9_ibfJwOvT-DdS8AX5pg7otStQBxRCH
X-Proofpoint-GUID: H9_ibfJwOvT-DdS8AX5pg7otStQBxRCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX4C2ldYhSvsLQ
 rpwb3utV7/md+U/Kal3jUQvfi07FYf+8yT3buw5Yis4lnuLfVVvkhT8ERmM1gpVWO9n/WtufzQn
 HnuuoJDTH6hDt7L4OTjyRhQ063g8+wiZKELpLltKSzhlNwmasPD3TU+w7fgZE19mtjC7xiQkXlp
 U+lg6/QbfnB8gVvOnPWJRkRKucmUAbFXf7BQwSc2R5APAII0PEINkzep8PINTF2Ky+RIU7O/mrn
 QoyZNyax53u5vvD5x4BmANrTEDlVQ+P3IoqSqneEv9aMaHUZjv+ycHCal+oK1NTA8aD6rms1WNG
 eJcQUzop8bFirF606Q/EU0Li5WkRKm1X62fxjboWEpeEwHEKXHUg9me9j10BwOyR8gUFWpPUs3q
 63Q1Z6PP8FeXIoWqPompn5ApZxLSih7TK39S0c73KMtwXxwNkkZ49TL+Gz1fJnNev0xDQkiYDs9
 ai4TtjieoMbMZRSG6bQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=10 priorityscore=1501
 impostorscore=10 phishscore=0 lowpriorityscore=10 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240076
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
...
> 
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

@Andrew, could you pick up the rest of these (everything but 4 and 8)?
I'd like to send the next batch of uffd fixes I have on top of these.

Thanks,
Tal

